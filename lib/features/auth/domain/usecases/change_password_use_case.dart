import 'package:car_mate/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

class ChangePasswordUseCase {
  final AuthRepo _authRepo;

  ChangePasswordUseCase(this._authRepo);

  Future<Either<Failure, void>> call({
    required String email,
    required String newPassword,
  }) async =>
      _authRepo.changePassword(email: email, newPassword: newPassword);
}