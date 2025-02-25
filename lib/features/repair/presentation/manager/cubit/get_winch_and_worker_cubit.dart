import 'package:car_mate/features/repair/data/models/winch_model.dart';
import 'package:car_mate/features/repair/data/models/worker_model.dart';
import 'package:car_mate/features/repair/data/repo/get_worker_and_winch_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_winch_and_worker_state.dart';

class GetWinchAndWorkerCubit extends Cubit<GetWinchAndWorkerState> {
  GetWinchAndWorkerCubit(this.getWorkerAndWinchRepo)
      : super(GetWinchAndWorkerInitial());

  final GetWorkerAndWinchRepo getWorkerAndWinchRepo;

  Future<void> fetchWinch() async {
    emit(GetWinchLoadingState());

    var result = await getWorkerAndWinchRepo.fetchWinch();

    result.fold(
      (failure) {
        emit(GetWinchFailureState(errorMessage: failure.message));
      },
      (winchsList) {
        emit(GetWinchSuccessfullyState(winchsList: winchsList));
      },
    );
  }

  Future<void> fetchWorker() async {
    emit(GetWorkerLoadingState());
    var result = await getWorkerAndWinchRepo.fetchWorkers();
    result.fold(
      (failure) {
        emit(GetWorkerFailureState(errorMessage: failure.message));
      },
      (workerList) {
        emit(GetWorkerSuccessfullyState(workersList: workerList));
      },
    );
  }
}
