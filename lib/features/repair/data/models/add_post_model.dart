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

  AddPostModel copyWith({
    int? id,
    String? postContent,
    List<String>? images,
    int? userId,
    String? updatedAt,
    String? createdAt,
    UserDataModel? userData,
  }) {
    return AddPostModel(
      id: id ?? this.id,
      postContent: postContent ?? this.postContent,
      images: images ?? this.images,
      userId: userId ?? this.userId,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      userData: userData ?? this.userData,
    );
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
