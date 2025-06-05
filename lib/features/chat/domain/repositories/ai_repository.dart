import 'package:car_mate/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../params/car_price_params.dart';

abstract class AiRepository {
  // car problem
  Future<Either<Failure, String>> getCarProblem({required String problem});

  // car price
  Future<Either<Failure, String>> getCarPrice({required CarPriceParams params});
}
