class OfferModel {
  final int id;
  final int workerId;
  final int postId;
  final String cash;
  final String note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Worker? worker;
  final Session? session;

  OfferModel({
    required this.id,
    required this.workerId,
    required this.postId,
    required this.cash,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    this.worker,
    this.session,
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
      session:
          json['session'] != null ? Session.fromJson(json['session']) : null,
    );
  }
}

class Worker {
  final int id;
  final String specialization;
  double rating;
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
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final List<String>? profilePhoto;

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
      profilePhoto: json['profilePhoto'] != null
          ? List<String>.from(json['profilePhoto'])
          : [],
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

class Session {
  final DateTime startDate;
  final DateTime? endDate;

  Session({
    required this.startDate,
    this.endDate,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      startDate: DateTime.parse(json['startDate']),
      endDate:
          json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,
    );
  }
}
