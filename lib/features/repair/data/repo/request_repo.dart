import 'dart:convert';
import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/features/repair/data/models/request_model.dart';
import 'package:http/http.dart' as http;
class OfferRepository {
  final String baseUrl = 'https://fb-m90x.onrender.com';

  Future<OfferModel> createOffer(int workerId, int postId, String cash, String note) async {
    final response = await http.post(
      Uri.parse('$baseUrl/offer/offer/2'),
      headers: {
        'Content-Type': 'application/json',
        'token': '${ConstantsManager.token}',
      },
      body: jsonEncode({
        'workerId': workerId,
        'postId': postId,
        'cash': cash,
        'note': note,
      }),
    );

    if (response.statusCode == 201) {
      return OfferModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to create offer: ${response.body}');
    }
  }

  Future<List<OfferModel>> getOffersForPost(int postId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/offer/2/$postId'),
      headers: {
        'Content-Type': 'application/json',
        'token': '${ConstantsManager.token}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((offerJson) => OfferModel.fromJson(offerJson)).toList();
    } else {
      throw Exception('Failed to fetch offers: ${response.body}');
    }
  }
}