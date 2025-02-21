import 'package:car_mate/core/errors/failures.dart';
import 'package:car_mate/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:car_mate/features/auth/domain/entities/user_entity.dart';
import 'package:car_mate/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/error_handler_service.dart';

class AuthRepoImp extends AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImp(this._authRemoteDataSource);

  // signup
  @override
  Future<Either<Failure, void>> signup({required UserEntity user}) async {
    try {
      await _authRemoteDataSource.signup(user: user);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ErrorHandlerService().handle(e));
    }
  }
  
  // login
  @override
  Future<Either<Failure, String>> login({required String email, required String password})async {
    try {
      return Right(await _authRemoteDataSource.login(email: email, password: password));
    } on Exception catch (e) {
      return Left(ErrorHandlerService().handle(e));
    }
  }
}
