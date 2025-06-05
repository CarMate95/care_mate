import 'package:car_mate/core/errors/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/api/dio_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/errors/error_handler_service.dart';
import '../../domain/repositories/ai_repository.dart';

class AiRepositoryImplementer implements AiRepository {
  final DioConsumer _dioConsumer;

  AiRepositoryImplementer(this._dioConsumer);

  @override
  Future<Either<Failure, String>> getCarProblem(
      {required String problem}) async {
    try {
      final result = await _dioConsumer.post(
        path: EndPoints.getCarProblem,
        body: {
          'problem_text': problem,
        },
        isFullUrl: true,
      );
      return Right(result['classification_recommendation'] as String);
    } on Exception catch (e) {
      return Left(ErrorHandlerService().handle(e));
    }
  }
}
