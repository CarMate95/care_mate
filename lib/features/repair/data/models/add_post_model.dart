class AddPostModel {
  final int? id;
  final String postContent;
  final List<String>? images;
  final int userId;
  final String updatedAt;
  final String createdAt;
  final UserDataModel userData;

  AddPostModel({
    this.id,
    required this.postContent,
    this.images,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.userData,
  });

  Map<String, String> toFormData() {
    return {
      'postContent': postContent,
      'userId': userId.toString(),
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'firstName': userData.firstName,
      'lastName': userData.lastName,
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
}