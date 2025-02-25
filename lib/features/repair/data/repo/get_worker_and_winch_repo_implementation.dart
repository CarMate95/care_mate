import 'package:car_mate/core/errors/failures.dart';
import 'package:car_mate/features/repair/data/models/winch_model.dart';
import 'package:car_mate/features/repair/data/models/worker_model.dart';
import 'package:car_mate/features/repair/data/repo/get_worker_and_winch_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class GetWorkerAndWinchRepoImplementation implements GetWorkerAndWinchRepo {
  final Dio dio = Dio();

  @override
  Future<Either<ServerFailure, List<WinchModel>>> fetchWinch() async {
    try {
      Response response =
          await dio.get('https://fb-m90x.onrender.com/winch/winches');

      Map<String, dynamic> jsonData = response.data;
      List<dynamic> data = jsonData['data'];

      List<WinchModel> winchesList =
          data.map((winch) => WinchModel.fromJson(winch)).toList();

      return Right(winchesList);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 404));
    }
  }

  @override
  Future<Either<ServerFailure, List<WorkerModel>>> fetchWorkers() async {
    try {
      Response response =
          await dio.get('https://fb-m90x.onrender.com/workers/workers');

      Map<String, dynamic> jsonData = response.data;
      List<dynamic> data = jsonData['data'];

      List<WorkerModel> workersList =
          data.map((worker) => WorkerModel.fromJson(worker)).toList();

      return Right(workersList);
    } on DioException catch (e) {
      return Left(ServerFailure(
          message: e.message!, statusCode: e.response?.statusCode ?? 500));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }
}
