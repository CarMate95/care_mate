import 'package:car_mate/core/errors/failures.dart';
import 'package:car_mate/features/repair/data/models/winch_model.dart';
import 'package:car_mate/features/repair/data/models/worker_model.dart';
import 'package:dartz/dartz.dart';

abstract class GetWorkerAndWinchRepo {
  Future<Either<ServerFailure, List<WorkerModel>>> fetchWorkers();
  Future<Either<ServerFailure, List<WinchModel>>> fetchWinch();
}
