class WinchResponse {
  final int count;
  final List<WinchModel> data;

  WinchResponse({
    required this.count,
    required this.data,
  });

  factory WinchResponse.fromJson(Map<String, dynamic> json) {
    return WinchResponse(
      count: json['count'] ?? 0,
      data: (json['data'] as List? ?? [])
          .map((item) => WinchModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'data': data.map((winch) => winch.toJson()).toList(),
    };
  }
}

class WinchModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String profilePhoto;
  final String area;
  final double rating;

  WinchModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePhoto,
    required this.area,
    required this.rating,
  });

  factory WinchModel.fromJson(Map<String, dynamic> json) {
    return WinchModel(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? 'Unknown',
      lastName: json['lastName'] ?? 'Unknown',
      email: json['email'] ?? 'No Email',
      profilePhoto: json['profilePhoto'] ?? '',
      area: json['area'] ?? 'Unknown',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profilePhoto': profilePhoto,
      'area': area,
      'rating': rating,
    };
  }
}
