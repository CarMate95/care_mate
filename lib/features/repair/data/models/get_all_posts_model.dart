class GetAllPostsModel {
  final int id;
  final String postContent;
  final List<String>? images;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AuthorModel author;

  GetAllPostsModel({
    required this.id,
    required this.postContent,
    required this.images,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.author,
  });

  factory GetAllPostsModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw Exception('Invalid post data');
    }
    return GetAllPostsModel(
      id: json['id'] ?? 0,
      postContent: json['postContent'] ?? "",
      images: List<String>.from(json['images']),
      userId: json['userId'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      author: AuthorModel.fromJson(json['author'] ?? {}),
    );
  }
}

class AuthorModel {
  final int id;
  final String firstName;
  final String lastName;
  final List<String> profilePhoto;

  AuthorModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePhoto,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePhoto: List<String>.from(json['profilePhoto']),
    );
  }
}
