import 'package:car_mate/config/themes/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

class CustomRating extends StatefulWidget {
  const CustomRating({super.key});

  @override
  State<CustomRating> createState() => _CustomRatingState();
}

class _CustomRatingState extends State<CustomRating> {
  double rating = 3.5;
  int starCount = 5;
  @override
  Widget build(BuildContext context) {
    return StarRating(
      size: 40.0,
      rating: rating,
      color: Colors.amber,
      borderColor: ColorManager.lightGrey,
      allowHalfRating: true,
      starCount: starCount,
      onRatingChanged: (rating) => setState(() {
        this.rating = rating;
      }),
    );
  }
}
