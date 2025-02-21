import 'package:car_mate/core/api/dio_consumer.dart';

import '../../../../core/api/end_points.dart';
import '../../domain/entities/user_entity.dart';

class AuthRemoteDataSource {
  final DioConsumer _dioConsumer;

  AuthRemoteDataSource(this._dioConsumer);

  // signup
  Future<void> signup({required UserEntity user}) async {
    await _dioConsumer.post(
      path: EndPoints.signup,
      body: user.toJson(),
    );
  }

  // login
  Future<String> login({
    required String email,
    required String password,
  }) async {
    var response = await _dioConsumer.post(
      path: EndPoints.login,
      body: {
        'email': email,
        'password': password,
      },
    );

    return response['data']['token'];
    // return await _dioConsumer.post(
    //   path: EndPoints.login,
    //   body: {
    //     'email': email,
    //     'password': password,
    //   },
    // );
  }
}
