class WorkerModel {
  final int id;
  final String specialization;
  final double rating;
  final String location;

  WorkerModel({
    required this.id,
    required this.specialization,
    required this.rating,
    required this.location,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      id: json['id'],
      specialization: json['specialization'],
      rating: (json['rating'] as num).toDouble(),
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'specialization': specialization,
      'rating': rating,
      'location': location,
    };
  }
}