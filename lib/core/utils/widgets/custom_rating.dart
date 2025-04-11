import 'package:car_mate/config/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class CustomRating extends StatelessWidget {
  const CustomRating(
      {super.key, required this.rate, required this.onRatingChanged});
  final double rate;
  final void Function(double)? onRatingChanged;

  @override
  Widget build(BuildContext context) {
    return StarRating(
      size: 40.0,
      rating: rate,
      color: Colors.amber,
      borderColor: ColorManager.lightGrey,
      allowHalfRating: true,
      starCount: 5,
      onRatingChanged: onRatingChanged,
    );
  }
}
