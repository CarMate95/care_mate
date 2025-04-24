import 'package:car_mate/features/repair/data/repo/request_repo_implementation.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetOffersCubit extends Cubit<GetOffersStates> {
  GetOffersCubit(this.offerRepository) : super(GetOffersInitialState());

  final OfferRepositoryImplementation offerRepository;

  Future<void> fetchOffers(int postId) async {
    emit(GetOffersLoadingState());

    var result = await offerRepository.getOffersForPost(postId);

    result.fold(
      (failure) {
        emit(GetOffersFailerState(errorMessage: failure.toString()));
      },
      (offersList) {
        emit(GetOffersSuccessState(offers: offersList));
      },
    );
  }

  Future<void> fetchWinch() async {
    emit(GetWinchLoadingState());

    var result = await offerRepository.fetchWinch();

    result.fold(
      (failure) {
        emit(GetWinchFailureState(errorMessage: failure.message));
      },
      (winchsList) {
        emit(GetWinchSuccessfullyState(winchsList: winchsList));
      },
    );
  }

  Future<void> fetchSessions() async {
    emit(GetSessionsLoadingState());

    var result = await offerRepository.fetchSessions();

    result.fold(
      (failure) {
        emit(GetSessionsFailerState(errorMessage: failure.message));
      },
      (sessionsList) {
        emit(GetSessionsSuccessState(sessionsList: sessionsList));
      },
    );
  }

  Future<void> startSession({
    required int postId,
    required int offerId,
    required String startDate,
  }) async {
    emit(StartSessionLoadingState());

    final result = await offerRepository.sentStartSession(
      postId: postId,
      offerId: offerId,
      startDate: startDate,
    );

    result.fold(
      (error) => emit(StartSessionFailureState(errorMessage: error)),
      (message) => emit(StartSessionSuccessState(message: message)),
    );
  }

  Future<void> endSession(
      {required int sessionId,
      required String endDate,
      required bool isDone}) async {
    emit(EndSessionLoadingState());

    final result = await offerRepository.endSession(
      endDate: endDate,
      sessionId: sessionId,
      isDone: isDone,
    );

    result.fold(
      (error) => emit(EndSessionFailureState(errorMessage: error)),
      (message) => emit(EndSessionSuccessState(message: message)),
    );
  }
}

// class OfferModel {
//   final int id;
//   final int workerId;
//   final int postId;
//   final String cash;
//   final String note;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final bool isAccepted; // إضافة isAccepted
//   final bool isClosed; // إضافة isClosed
//   final Worker? worker;
//   final Session? session;

//   OfferModel({
//     required this.id,
//     required this.workerId,
//     required this.postId,
//     required this.cash,
//     required this.note,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.isAccepted,
//     required this.isClosed,
//     this.worker,
//     this.session,
//   });

//   factory OfferModel.fromJson(Map<String, dynamic> json) {
//     return OfferModel(
//       id: json['id'],
//       workerId: json['workerId'],
//       postId: json['postId'],
//       cash: json['cash'],
//       note: json['note'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       isAccepted: json['isAccepted'] ?? false, // Add default value for null
//       isClosed: json['isClosed'] ?? false, // Add default value for null
//       worker: json['worker'] != null ? Worker.fromJson(json['worker']) : null,
//       session:
//           json['session'] != null ? Session.fromJson(json['session']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'workerId': workerId,
//       'postId': postId,
//       'cash': cash,
//       'note': note,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//       'isAccepted': isAccepted,
//       'isClosed': isClosed,
//       'worker': worker?.toJson(),
//       'session': session?.toJson(),
//     };
//   }
// }

// class Worker {
//   final int id;
//   final String specialization;
//   double rating;
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
//       rating: json['rating'].toDouble(),
//       location: json['location'],
//       user: User.fromJson(json['User']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'specialization': specialization,
//       'rating': rating,
//       'location': location,
//       'User': user.toJson(),
//     };
//   }
// }

// class User {
//   final int id;
//   final String? firstName;
//   final String? lastName;
//   final String? email;
//   final String? phone;
//   final List<String>? profilePhoto;

//   User({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//     required this.profilePhoto,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       email: json['email'],
//       phone: json['phone'],
//       profilePhoto: json['profilePhoto'] != null
//           ? List<String>.from(json['profilePhoto'])
//           : [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'firstName': firstName,
//       'lastName': lastName,
//       'email': email,
//       'phone': phone,
//       'profilePhoto': profilePhoto,
//     };
//   }
// }

// class Session {
//   final DateTime startDate;
//   final DateTime? endDate;

//   Session({
//     required this.startDate,
//     this.endDate,
//   });

//   factory Session.fromJson(Map<String, dynamic> json) {
//     return Session(
//       startDate: DateTime.parse(json['startDate']),
//       endDate:
//           json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'startDate': startDate.toIso8601String(),
//       'endDate': endDate?.toIso8601String(),
//     };
//   }
// }

// class OfferModel {
//   final int id;
//   final int workerId;
//   final int postId;
//   final String cash;
//   final String note;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final Worker? worker;
//   final Session? session;

//   OfferModel({
//     required this.id,
//     required this.workerId,
//     required this.postId,
//     required this.cash,
//     required this.note,
//     required this.createdAt,
//     required this.updatedAt,
//     this.worker,
//     this.session,
//   });

//   factory OfferModel.fromJson(Map<String, dynamic> json) {
//     return OfferModel(
//       id: json['id'],
//       workerId: json['workerId'],
//       postId: json['postId'],
//       cash: json['cash'],
//       note: json['note'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       worker: json['worker'] != null ? Worker.fromJson(json['worker']) : null,
//       session:
//           json['session'] != null ? Session.fromJson(json['session']) : null,
//     );
//   }
// }

// class Worker {
//   final int id;
//   final String specialization;
//   double rating;
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
//       rating: json['rating'].toDouble(),
//       location: json['location'],
//       user: User.fromJson(json['User']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'specialization': specialization,
//       'rating': rating,
//       'location': location,
//       'User': user.toJson(),
//     };
//   }
// }

// class User {
//   final int id;
//   final String? firstName;
//   final String? lastName;
//   final String? email;
//   final String? phone;
//   final List<String>? profilePhoto;

//   User({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//     required this.profilePhoto,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       email: json['email'],
//       phone: json['phone'],
//       profilePhoto: json['profilePhoto'] != null
//           ? List<String>.from(json['profilePhoto'])
//           : [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'firstName': firstName,
//       'lastName': lastName,
//       'email': email,
//       'phone': phone,
//       'profilePhoto': profilePhoto,
//     };
//   }
// }

// class Session {
//   final DateTime startDate;
//   final DateTime? endDate;

//   Session({
//     required this.startDate,
//     this.endDate,
//   });

//   factory Session.fromJson(Map<String, dynamic> json) {
//     return Session(
//       startDate: DateTime.parse(json['startDate']),
//       endDate:
//           json['endDate'] != null ? DateTime.tryParse(json['endDate']) : null,
//     );
//   }
// }
