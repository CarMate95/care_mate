import 'package:flutter/material.dart';

class CustomCircularAvatar extends StatelessWidget {
  const CustomCircularAvatar(
      {super.key,
      this.backgroundColor = Colors.redAccent,
      required this.image});
  final Color? backgroundColor;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
      // child: NetworkImage(
      //   image,
      //   fit: BoxFit.cover,
      // ),
    );
  }
}
