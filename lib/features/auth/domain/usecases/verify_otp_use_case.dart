import 'package:car_mate/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class VerifyOtpUseCase {
  final AuthRepo _authRepo;

  VerifyOtpUseCase(this._authRepo);

  Future<Either<Failure, void>> call({
    required String email,
    required String otp,
  }) async {
    return _authRepo.verifyOtp(email: email, otp: otp);
  }
}
