import 'package:car_mate/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/user_data.dart';

class SignupUseCase {
  final AuthRepo _authRepo;

  SignupUseCase(this._authRepo);

  Future<Either<Failure, void>> call({required UserData user}) async =>
      _authRepo.signup(user: user);
}
