import 'package:car_mate/core/utils/di/di.dart';
import 'package:car_mate/core/utils/functions/kprint.dart';
import 'package:car_mate/features/auth/data/models/user_model.dart';
import 'package:car_mate/features/profile/widgets/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(BuildContext context) => sl.get<ProfileCubit>();

  UserModel? userModel;

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final result = await ProfileService.getProfile();
      if (result != null) {
        userModel = UserModel.fromJson(result);
        kprint(userModel?.worker?.specialization ?? 'No Specialization');
        emit(ProfileSuccess());
      }
    } on Exception catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
