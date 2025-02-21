import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repo.dart';

class LoginUseCase {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  Future<Either<Failure, String>> call({
    required String email,
    required String password,
  }) async =>
      _authRepo.login(email: email, password: password);
}
