import 'package:car_mate/core/errors/failures.dart';
import 'package:car_mate/features/repair/data/models/request_model.dart';
import 'package:car_mate/features/repair/data/models/session_model.dart';
import 'package:car_mate/features/repair/data/models/winch_model.dart';
import 'package:dartz/dartz.dart';

abstract class RequestRepo {
  Future<Either<ServerFailure, List<OfferModel>>> getOffersForPost(int postId);
  Future<Either<ServerFailure, List<WinchModel>>> fetchWinch();
  Future<Either<ServerFailure, List<SessionModel>>> fetchSessions();
  Future<Either<String, String>> sentStartSession(
      {required int postId, required int offerId, required String startDate});
  Future<Either<String, String>> endSession(
      {required int sessionId, required String endDate, required bool isDone});
}
