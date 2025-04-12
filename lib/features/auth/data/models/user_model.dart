import 'package:car_mate/features/auth/data/models/user_data.dart';

import '../../../repair/data/models/worker_model.dart';

class UserModel {
  final UserData userData;
  final WorkerModel? worker;

  UserModel({required this.userData, this.worker});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userData: UserData.fromJson(json['user']),
      worker: json['worker'] != null ? WorkerModel.fromJson(json['worker']) : null,
    );
  }
}