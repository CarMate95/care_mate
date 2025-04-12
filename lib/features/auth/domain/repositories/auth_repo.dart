import 'package:car_mate/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/user_data.dart';

abstract class AuthRepo {
  // signup
  Future<Either<Failure, void>> signup({required UserData user});

  // login
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  });

  // forget password
  Future<Either<Failure, void>> forgetPassword({required String email});

  // verify otp
  Future<Either<Failure, void>> verifyOtp({
    required String email,
    required String otp,
  });

  // change password
  Future<Either<Failure, void>> changePassword({
    required String email,
    required String newPassword,
  });
}
