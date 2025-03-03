class GetSpecificPostModel {
  final int id;
  final String postContent;
  final List<String>? images;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final GetPostUserData user;

  GetSpecificPostModel({
    required this.id,
    required this.postContent,
    required this.images,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory GetSpecificPostModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw Exception('Invalid post data');
    }
    return GetSpecificPostModel(
      id: json['id'] ?? 0,
      postContent: json['postContent'] ?? "",
      images: List<String>.from(json['images']),
      userId: json['userId'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: GetPostUserData.fromJson(json['user'] ?? {}),
    );
  }
}

class GetPostUserData {
  final String firstName;
  final String lastName;
  final List<String> profilePhoto;

  GetPostUserData({
    required this.firstName,
    required this.lastName,
    required this.profilePhoto,
  });

  factory GetPostUserData.fromJson(Map<String, dynamic> json) {
    return GetPostUserData(
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePhoto: List<String>.from(json['profilePhoto']),
    );
  }
}
