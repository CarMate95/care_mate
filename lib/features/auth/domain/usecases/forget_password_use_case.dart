import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repo.dart';

class ForgetPasswordUseCase {
  final AuthRepo _authRepo;

  ForgetPasswordUseCase(this._authRepo);

  Future<Either<Failure, void>> call({required String email}) async =>
      _authRepo.forgetPassword(email: email);
}
