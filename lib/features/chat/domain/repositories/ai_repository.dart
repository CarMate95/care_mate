import 'package:car_mate/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AiRepository {
  // car problem
  Future<Either<Failure, String>> getCarProblem({required String problem});
}
