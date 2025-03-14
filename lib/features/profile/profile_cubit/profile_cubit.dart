import 'package:car_mate/core/utils/di/di.dart';
import 'package:car_mate/core/utils/functions/kprint.dart';
import 'package:car_mate/features/auth/domain/entities/user_entity.dart';
import 'package:car_mate/features/profile/widgets/profile_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get() => sl<ProfileCubit>();

  UserEntity? userEntity;

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final result = await ProfileService.getProfile();
      if (result != null) {
        userEntity = UserEntity.fromJson(result);
        kprint(userEntity?.profileImage ?? 'null image');
        emit(ProfileSuccess());
      }
    } on Exception catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
