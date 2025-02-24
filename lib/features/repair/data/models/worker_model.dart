// class WorkerResponse {
//   final int count;
//   final List<WorkerModel> workers;

//   WorkerResponse({
//     required this.count,
//     required this.workers,
//   });
// }

// class WorkerModel {
//   final int id;
//   final String specialization;
//   final int rating;
//   final String location;
//   final UserModel userModel;

//   WorkerModel({
//     required this.id,
//     required this.specialization,
//     required this.rating,
//     required this.location,
//     required this.userModel,
//   });
// }

// class UserModel {
//   final int id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phone;
//   final List<String> profilePhoto;

//   UserModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//     required this.profilePhoto,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       email: json['email'],
//       phone: json['phone'],
//       profilePhoto: json['profilePhoto'],
//     );
//   }
// }

class WorkerModel {
  final int id;
  final String specialization;
  final double rating;
  final String location;
  final User user;

  WorkerModel({
    required this.id,
    required this.specialization,
    required this.rating,
    required this.location,
    required this.user,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      id: json['id'],
      specialization: json['specialization'],
      rating: (json['rating'] as num).toDouble(),
      location: json['location'],
      user: User.fromJson(json['User']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'specialization': specialization,
      'rating': rating,
      'location': location,
      'User': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final List<String> profilePhoto;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.profilePhoto,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      profilePhoto: List<String>.from(json['profilePhoto']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'profilePhoto': profilePhoto,
    };
  }
}
