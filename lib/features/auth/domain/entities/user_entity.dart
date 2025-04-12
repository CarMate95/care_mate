import 'package:car_mate/core/utils/enums/user_type.dart';

class UserEntity {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? phoneNumber;
  final String? location;
  final UserRole? role;
  final String? specialization;
  final String? profileImage;

  UserEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.location,
    this.role,
    this.specialization,
    this.profileImage,
    this.id,
  });

  // toJson
  Map<String, dynamic> toJson() {
    if (location == null && phoneNumber == null && specialization == null) {
      return {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'role': role!.name,
      };
    }
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phone': phoneNumber,
      'location': location,
      'role': role!.name,
      'specialization': specialization,
    };
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'] ?? '',
      phoneNumber: json['phone'],
      location: json['location'],
      profileImage: json['profilePhoto'][0],
      //   role: json['role'],
      //   specialization: json['specialization'],
    );
  }
}
