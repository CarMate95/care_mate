import 'package:car_mate/core/utils/enums/user_type.dart';

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final List<String>? profilePhoto;
  final String status;
  final UserRole role;
  final bool isActive;
  final String? otp;
  final String? otpExpiry;
  final int otpAttempts;
  final bool otpVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.profilePhoto,
    required this.status,
    required this.role,
    required this.isActive,
    this.otp,
    this.otpExpiry,
    required this.otpAttempts,
    required this.otpVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']??0,
      firstName: json['firstName']??'',
      lastName: json['lastName']??'',
      email: json['email']??'',
      phone: json['phone']??'',
      profilePhoto: (json['profilePhoto'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      status: json['status']??'',
      role: UserRole.values.firstWhere((e) => e.name == json['role']),
      isActive: json['isActive'],
      otp: json['otp']??'',
      otpExpiry: json['otpExpiry']??'',
      otpAttempts: json['otpAttempts']??0,
      otpVerified: json['otpVerified'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}