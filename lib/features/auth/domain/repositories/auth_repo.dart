import 'package:car_mate/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';

abstract class AuthRepo {
  // signup
  Future<Either<Failure, void>> signup({required UserEntity user});

  // login
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  });
}
