// class OfferModel {
//   final int id;
//   final int workerId;
//   final int postId;
//   final String cash;
//   final String note;
//   final String createdAt;
//   final String updatedAt;

//   OfferModel({
//     required this.id,
//     required this.workerId,
//     required this.postId,
//     required this.cash,
//     required this.note,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory OfferModel.fromJson(Map<String, dynamic> json) {
//     return OfferModel(
//       id: json['id']as int,
//       workerId: json['workerId'] as int,
//       postId: json['postId']as int,
//       cash: json['cash'],
//       note: json['note'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//     );
//   }
// }
class OfferModel {
  final int id;
  final int workerId;
  final int postId;
  final String cash;
  final String note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Worker? worker;

  OfferModel({
    required this.id,
    required this.workerId,
    required this.postId,
    required this.cash,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    this.worker,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      workerId: json['workerId'],
      postId: json['postId'],
      cash: json['cash'],
      note: json['note'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      worker: json['worker'] != null ? Worker.fromJson(json['worker']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workerId': workerId,
      'postId': postId,
      'cash': cash,
      'note': note,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'worker': worker?.toJson(),
    };
  }
}

class Worker {
  final int id;
  final String specialization;
  final double rating;
  final String location;
  final User user;

  Worker({
    required this.id,
    required this.specialization,
    required this.rating,
    required this.location,
    required this.user,
  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      id: json['id'],
      specialization: json['specialization'],
      rating: json['rating'].toDouble(),
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
  final String? phone;
  final List<String> profilePhoto;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
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
