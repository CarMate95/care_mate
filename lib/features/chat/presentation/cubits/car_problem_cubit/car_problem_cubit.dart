import 'package:car_mate/core/api/dio_consumer.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/ai_repository_implementer.dart';

part 'car_problem_state.dart';

class CarProblemCubit extends Cubit<CarProblemState> {
  CarProblemCubit() : super(CarProblemInitial());
  final aiRepository = AiRepositoryImplementer(DioConsumer(dio: Dio()));

  static CarProblemCubit get(context) => BlocProvider.of(context);

  // get car problem
  Future<void> getCarProblem({required String problem}) async {
    emit(CarProblemLoading());
    final result = await aiRepository.getCarProblem(problem: problem);
    result.fold((error) {
      emit(CarProblemError(message: error.message));
    }, (problem) {
      emit(CarProblemSuccess(problem: problem));
    });
  }
}
