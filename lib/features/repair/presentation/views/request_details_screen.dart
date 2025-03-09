
import 'package:car_mate/features/repair/presentation/widgets/request_detailsbody.dart';
import 'package:flutter/material.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({
    super.key,
    required this.postId,
  });
  final int postId;

  @override
  Widget build(BuildContext context) {
    return RequestDetailsBody(
      postId: postId,
    );
  }
}
