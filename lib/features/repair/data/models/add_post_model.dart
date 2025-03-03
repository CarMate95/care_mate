class AddPostModel {
  final int id;
  final String postContent; // Revert to postContent
  final List<String>? images;
  final int userId;
  final String updatedAt;
  final String createdAt;
  final UserDataModel userData;

  AddPostModel({
    required this.id,
    required this.postContent, // Back to postContent
    this.images,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.userData,
  });

  factory AddPostModel.fromJson(Map<String, dynamic> json) {
    return AddPostModel(
      id: json['id'],
      postContent: json['postContent'],
      images:
          (json['images'] as List?)?.map((item) => item.toString()).toList() ??
              [],
      userId: json['userId'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
      userData: UserDataModel.fromJson(json['userData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postContent': postContent,
      'images': images??[], // Ensure it's always a list
      'userId': userId,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'userData': userData.toJson(),
    };
  }
}

class UserDataModel {
  final String firstName;
  final String lastName;
  final List<String> profilePhoto;

  UserDataModel({
    required this.firstName,
    required this.lastName,
    required this.profilePhoto,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePhoto: json['profilePhoto'] != null
          ? List<String>.from(json['profilePhoto'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'profilePhoto': profilePhoto??[],
    };
  }
}
