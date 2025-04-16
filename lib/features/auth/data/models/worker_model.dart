class WorkerModel {
  int? id;
  String? specialization;
  int? rating;
  String? location;

  WorkerModel({this.id, this.specialization, this.rating, this.location});

  factory WorkerModel.fromJson(Map<String, dynamic> json) => WorkerModel(
        id: json['id'] as int?,
        specialization: json['specialization'] as String?,
        rating: json['rating'] as int?,
        location: json['location'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'specialization': specialization,
        'rating': rating,
        'location': location,
      };
}
