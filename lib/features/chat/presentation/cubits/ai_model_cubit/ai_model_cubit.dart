import 'package:car_mate/core/api/dio_consumer.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/ai_repository_implementer.dart';
import '../../../domain/params/car_price_params.dart';

part 'ai_model_state.dart';

class AiModelCubit extends Cubit<AiModelState> {
  AiModelCubit() : super(AiModelInitial());
  final aiRepository = AiRepositoryImplementer(DioConsumer(dio: Dio()));

  static AiModelCubit get(context) => BlocProvider.of(context);

  // get car problem
  Future<void> getCarProblem({required String problem}) async {
    emit(AiModelLoading());
    final result = await aiRepository.getCarProblem(problem: problem);
    result.fold((error) {
      emit(AiModelError(message: error.message));
    }, (problem) {
      emit(AiModelSuccess(message: problem));
    });
  }

  // get car price
  Future<void> getCarPrice({required CarPriceParams params}) async {
    emit(AiModelLoading());
    final result = await aiRepository.getCarPrice(params: params);
    result.fold((error) {
      emit(AiModelError(message: error.message));
    }, (price) {
      emit(AiModelSuccess(message: price));
    });
  }
}
