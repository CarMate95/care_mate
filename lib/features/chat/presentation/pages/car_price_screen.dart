import 'package:car_mate/core/utils/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/text_manager.dart';
import '../../../../core/utils/widgets/custom_scaffold.dart';
import '../../../../core/utils/widgets/custom_scaffold_message.dart';
import '../../data/models/car_price_form.dart';
import '../../domain/params/car_price_params.dart';
import '../cubits/ai_model_cubit/ai_model_cubit.dart';
import '../widgets/car_price_body.dart';
import '../widgets/success_ai_dialog.dart';

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
    return BlocProvider(
      create: (context) => AiModelCubit(),
      child: CustomScaffold(
        body: SingleChildScrollView(
          // sign up body
          child: CarPriceBody(carPriceForm: carPriceForm),
        ),
        bottomNavigationBar: BlocConsumer<AiModelCubit, AiModelState>(
          listener: (context, state) {
            if (state is AiModelSuccess) {
              // show dialog with price
              showSuccessAiDialog(
                context,
                title: TextManager.expectedCarPrice,
                message: state.message,
              );
            }
            if (state is AiModelError) {
              // show error message
              showScaffoldMessage(context, message: state.message);
            }
          },
          builder: (context, state) {
            var aiModelCubit = AiModelCubit.get(context);
            return IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: CustomElevatedButton(
                  isLoading: state is AiModelLoading,
                  onPressed: () async {
                    if (carPriceForm.formKey.currentState!.validate()) {
                      // get car price
                      await aiModelCubit.getCarPrice(
                        params: CarPriceParams(
                          millage:
                              int.parse(carPriceForm.millageController.text),
                          age: int.parse(carPriceForm.ageController.text),
                          carMake: carPriceForm.carMakeController.text,
                          carModel: carPriceForm.carModelController.text,
                          city: carPriceForm.cityController.text,
                          isAutomaticTransmission:
                              carPriceForm.isAutomaticTransmission,
                          isRemoteControl: carPriceForm.isRemoteControl,
                          isAirConditioner: carPriceForm.isAirConditioner,
                          isPowerSteering: carPriceForm.isPowerSteering,
                        ),
                      );
                    }
                  },
                  text: TextManager.getPrice,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
