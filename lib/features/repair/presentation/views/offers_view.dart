import 'package:car_mate/features/repair/presentation/widgets/offers_view_body.dart';
import 'package:flutter/material.dart';

class OffersView extends StatefulWidget {
  const OffersView({
    super.key,
  });

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  @override
  Widget build(BuildContext context) {
    final int postId = ModalRoute.of(context)!.settings.arguments as int;
    return OffersViewBody(
      postId: postId,
    );
  }
}
