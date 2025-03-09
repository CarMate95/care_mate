

class OfferModel {
  final int id;
  final int workerId;
  final int postId;
  final String cash;
  final String note;
  final String createdAt;
  final String updatedAt;

  OfferModel({
    required this.id,
    required this.workerId,
    required this.postId,
    required this.cash,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id']as int,
      workerId: json['workerId'] as int,
      postId: json['postId']as int,
      cash: json['cash'],
      note: json['note'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}