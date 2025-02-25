import 'package:car_mate/core/utils/enums/user_type.dart';

class UserEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? phoneNumber;
  final String? location;
  final UserRole role;
  final String? specialization;

  UserEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.location,
    required this.role,
    this.specialization,
  });

  // toJson
  Map<String, dynamic> toJson() {
    if (location == null && phoneNumber == null && specialization == null) {
      return {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'role': role.name,
      };
    }
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phone': phoneNumber,
      'location': location,
      'role': role.name,
      'specialization': specialization,
    };
  }
}
