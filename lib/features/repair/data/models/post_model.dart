class PostModel {
  final int id;
  final String postContent;
  final List<String> images;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostModel({
    required this.id,
    required this.postContent,
    required this.images,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      postContent: json['postContent'],
      images: List<String>.from(json['images']),
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  PostModel copyWith({
    int? id,
    String? postContent,
    List<String>? images,
    int? userId,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      postContent: postContent ?? this.postContent,
      images: images ?? this.images,
      userId: userId ?? this.userId,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
