import 'package:car_mate/core/utils/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/custom_scaffold.dart';
import '../../data/models/car_price_form.dart';
import '../widgets/car_price_body.dart';

class CarPriceScreen extends StatefulWidget {
  const CarPriceScreen({super.key});

  @override
  State<CarPriceScreen> createState() => _CarPriceScreenState();
}

class _CarPriceScreenState extends State<CarPriceScreen> {
  final CarPriceForm carPriceForm = CarPriceForm();

  @override
  void dispose() {
    super.dispose();
    carPriceForm.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        // sign up body
        child: CarPriceBody(carPriceForm: carPriceForm),
      ),
      bottomNavigationBar: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomElevatedButton(
            // isLoading: true,
            onPressed: () {},
            text: 'Get Price',
          ),
        ),
      ),
    );
  }
}
