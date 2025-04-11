// class SessionResponse {
//   final String status;
//   final List<SessionModel> sessions;

//   SessionResponse({required this.status, required this.sessions});

//   factory SessionResponse.fromJson(Map<String, dynamic> json) {
//     return SessionResponse(
//       status: json['status'],
//       sessions: List<SessionModel>.from(
//         (json['data']['sessions'] as List).map((e) => SessionModel.fromJson(e)),
//       ),
//     );
//   }
// }

// class SessionModel {
//   final int id;
//   final int userId;
//   final int postId;
//   final int workerId;
//   final int offerId;
//   final String? startDate;
//   final String? endDate;
//   final bool isDone;
//   final String createdAt;
//   final String updatedAt;
//   final Post post;
//   final Worker worker;
//   final Offer offer;
//   final User user;

//   SessionModel({
//     required this.id,
//     required this.userId,
//     required this.postId,
//     required this.workerId,
//     required this.offerId,
//     this.startDate,
//     this.endDate,
//     required this.isDone,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.post,
//     required this.worker,
//     required this.offer,
//     required this.user,
//   });

//   factory SessionModel.fromJson(Map<String, dynamic> json) {
//     return SessionModel(
//       id: json['id'],
//       userId: json['userId'],
//       postId: json['postId'],
//       workerId: json['workerId'],
//       offerId: json['offerId'],
//       startDate: json['startDate'],
//       endDate: json['endDate'],
//       isDone: json['isDone'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//       post: Post.fromJson(json['post']),
//       worker: Worker.fromJson(json['Worker']),
//       offer: Offer.fromJson(json['offer']),
//       user: User.fromJson(json['user']),
//     );
//   }
// }

// class Post {
//   final int id;
//   final String postContent;
//   final List<dynamic> images;
//   final int userId;
//   final User author;

//   Post({
//     required this.id,
//     required this.postContent,
//     required this.images,
//     required this.userId,
//     required this.author,
//   });

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       id: json['id'],
//       postContent: json['postContent'],
//       images: List<dynamic>.from(json['images']),
//       userId: json['userId'],
//       author: User.fromJson(json['author']),
//     );
//   }
// }

// class Worker {
//   final int id;
//   final String specialization;
//   final int rating;
//   final String location;
//   final User user;

//   Worker({
//     required this.id,
//     required this.specialization,
//     required this.rating,
//     required this.location,
//     required this.user,
//   });

//   factory Worker.fromJson(Map<String, dynamic> json) {
//     return Worker(
//       id: json['id'],
//       specialization: json['specialization'],
//       rating: json['rating'],
//       location: json['location'],
//       user: User.fromJson(json['User']),
//     );
//   }
// }

// class Offer {
//   final int id;
//   final String cash;
//   final String note;
//   final int workerId;
//   final WorkerSimple worker;

//   Offer({
//     required this.id,
//     required this.cash,
//     required this.note,
//     required this.workerId,
//     required this.worker,
//   });

//   factory Offer.fromJson(Map<String, dynamic> json) {
//     return Offer(
//       id: json['id'],
//       cash: json['cash'],
//       note: json['note'],
//       workerId: json['workerId'],
//       worker: WorkerSimple.fromJson(json['worker']),
//     );
//   }
// }

// class WorkerSimple {
//   final int id;
//   final String specialization;
//   final int rating;
//   final User user;

//   WorkerSimple({
//     required this.id,
//     required this.specialization,
//     required this.rating,
//     required this.user,
//   });

//   factory WorkerSimple.fromJson(Map<String, dynamic> json) {
//     return WorkerSimple(
//       id: json['id'],
//       specialization: json['specialization'],
//       rating: json['rating'],
//       user: User.fromJson(json['User']),
//     );
//   }
// }

// class User {
//   final int id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String? phone;

//   User({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     this.phone,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       email: json['email'],
//       phone: json['phone'],

//       // Might be null in some responses
//     );
//   }
// }

class SessionResponse {
  final String status;
  final List<SessionModel> sessions;

  SessionResponse({required this.status, required this.sessions});

  factory SessionResponse.fromJson(Map<String, dynamic> json) {
    return SessionResponse(
      status: json['status'],
      sessions: List<SessionModel>.from(
        (json['data']['sessions'] as List).map((e) => SessionModel.fromJson(e)),
      ),
    );
  }
}

class SessionModel {
  final int id;
  final int userId;
  final int postId;
  final int workerId;
  final int offerId;
  final String? startDate;
  final String? endDate;
  final bool isDone;
  final String createdAt;
  final String updatedAt;
  final Post post;
  final Worker worker;
  final Offer offer;
  final User user;

  SessionModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.workerId,
    required this.offerId,
    this.startDate,
    this.endDate,
    required this.isDone,
    required this.createdAt,
    required this.updatedAt,
    required this.post,
    required this.worker,
    required this.offer,
    required this.user,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      userId: json['userId'],
      postId: json['postId'],
      workerId: json['workerId'],
      offerId: json['offerId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      isDone: json['isDone'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      post: Post.fromJson(json['post']),
      worker: Worker.fromJson(json['Worker']),
      offer: Offer.fromJson(json['offer']),
      user: User.fromJson(json['user']),
    );
  }
}

class Post {
  final int id;
  final String postContent;
  final List<dynamic> images;
  final int userId;
  final User author;

  Post({
    required this.id,
    required this.postContent,
    required this.images,
    required this.userId,
    required this.author,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      postContent: json['postContent'],
      images: List<dynamic>.from(json['images']),
      userId: json['userId'],
      author: User.fromJson(json['author']),
    );
  }
}

class Worker {
  final int id;
  final String specialization;
  final int rating;
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
      rating: json['rating'],
      location: json['location'],
      user: User.fromJson(json['User']),
    );
  }
}

class Offer {
  final int id;
  final String cash;
  final String note;
  final int workerId;
  final WorkerSimple worker;

  Offer({
    required this.id,
    required this.cash,
    required this.note,
    required this.workerId,
    required this.worker,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      cash: json['cash'],
      note: json['note'],
      workerId: json['workerId'],
      worker: WorkerSimple.fromJson(json['worker']),
    );
  }
}

class WorkerSimple {
  final int id;
  final String specialization;
  final int rating;
  final User user;

  WorkerSimple({
    required this.id,
    required this.specialization,
    required this.rating,
    required this.user,
  });

  factory WorkerSimple.fromJson(Map<String, dynamic> json) {
    return WorkerSimple(
      id: json['id'],
      specialization: json['specialization'],
      rating: json['rating'],
      user: User.fromJson(json['User']),
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final List<String>? profilePhoto;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.profilePhoto,
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
          : null,
    );
  }
}
