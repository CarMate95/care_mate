import 'dart:convert';

import 'package:car_mate/core/api/dio_consumer.dart';
import 'package:car_mate/core/errors/failures.dart';
import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/features/repair/data/models/request_model.dart';
import 'package:car_mate/features/repair/data/models/session_model.dart';
import 'package:car_mate/features/repair/data/models/winch_model.dart';
import 'package:car_mate/features/repair/data/repo/request_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OfferRepositoryImplementation implements RequestRepo {
  final String baseUrl = 'https://fb-m90x.onrender.com';
  final Dio dio = Dio();

  Future<OfferModel?> createOffer(
    int workerId,
    int postId,
    String cash,
    String note,
    BuildContext context,
  ) async {
    DioConsumer dio = DioConsumer(dio: Dio());

    try {
      final response = await dio.post(
        path: '/offer/offer/$postId',
        body: {
          'cash': int.parse(cash),
          'note': note,
        },
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Offer sent successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      return OfferModel.fromJson(response['data']['offer']);
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send offer: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }

  @override
  Future<Either<ServerFailure, List<OfferModel>>> getOffersForPost(
      int postId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/offer/$postId'),
      headers: {
        'Content-Type': 'application/json',
        'token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFiZG93ODg5NUBnbWFpbC5jb20iLCJpZCI6Mywicm9sZSI6IndvcmtlciIsImlhdCI6MTczODg5MzE2MywiZXhwIjoxNzQ3NTMzMTYzfQ.jmHbrEHS9oUKnG_JruJLvQDT9Cgqw5hdugb9h0G2_5g',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data']['offers'];
      print(data);
      return Right(
          data.map((offerJson) => OfferModel.fromJson(offerJson)).toList());
    } else {
      Left(throw Exception('Failed to fetch offers: ${response.body}'));
    }
  }

  @override
  Future<Either<ServerFailure, List<WinchModel>>> fetchWinch() async {
    try {
      Response response = await dio.get('$baseUrl/winch/winches', data: {
        'token': '${ConstantsManager.token}',
      });

      Map<String, dynamic> jsonData = response.data;
      List<dynamic> data = jsonData['data'];

      List<WinchModel> winchesList =
          data.map((winch) => WinchModel.fromJson(winch)).toList();

      return Right(winchesList);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 404));
    }
  }

  @override
  Future<Either<ServerFailure, List<SessionModel>>> fetchSessions() async {
    try {
      final response = await dio.get(
        '$baseUrl/session/getMyOwnSessions',
        options: Options(
          headers: {
            'token': '${ConstantsManager.token}',
          },
        ),
      );

      if (response.statusCode == 200) {
        SessionResponse sessionResponse =
            SessionResponse.fromJson(response.data);

        return Right(sessionResponse.sessions);
      } else {
        return const Left(
            ServerFailure(message: 'Failed to load sessions', statusCode: 404));
      }
    } catch (e) {
      return Left(ServerFailure(
          message: 'Error fetching sessions: $e', statusCode: 404));
    }
  }

  @override
  Future<Either<String, String>> sentStartSession({
    required int postId,
    required int offerId,
    required String startDate,
  }) async {
    try {
      final response = await Dio().post(
        '$baseUrl/session/startsession/$postId/$offerId',
        data: {
          "startDate": startDate,
        },
        options: Options(
          headers: {
            "token": "${ConstantsManager.token}",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data['status'] == 'success') {
          final session = data['data']['session'];
          final message = 'Session started with ID: ${session['id']}';
          return Right(message);
        } else {
          return Left(data['message'] ??
              'A session for this post and offer already exists');
        }
      } else {
        return Left('Unexpected error: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Network error: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, String>> endSession({
    required int sessionId,
    required String endDate,
  }) async {
    try {
      final response = await Dio().put(
        '$baseUrl/session/endsession/$sessionId',
        data: {
          "endDate": endDate,
        },
        options: Options(
          headers: {
            "token": "${ConstantsManager.token}",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data['status'] == 'success') {
          final session = data['data']['session'];
          final message = 'Session ended with ID: ${session['id']}';
          return Right(message);
        } else {
          return Left(data['message'] ?? 'Unknown server response');
        }
      } else {
        return Right('Unexpected error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 403) {
        final errorData = e.response?.data;
        return Left(errorData['message'] ?? 'Bad request');
      }
      return Left('Network error: ${e.message}');
    } catch (e) {
      return Left('Unknown error: ${e.toString()}');
    }
  }
}
