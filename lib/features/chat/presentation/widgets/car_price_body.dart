import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/core/utils/widgets/custom_text_form_field.dart';
import 'package:car_mate/features/chat/data/models/car_price_form.dart';
import 'package:flutter/material.dart';

import 'main_app_bar.dart';

class CarPriceBody extends StatefulWidget {
  const CarPriceBody({super.key, required this.carPriceForm});
  final CarPriceForm carPriceForm;

  @override
  State<CarPriceBody> createState() => _CarPriceBodyState();
}

class _CarPriceBodyState extends State<CarPriceBody> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.carPriceForm.formKey,
      child: Column(
        children: [
          // custom app bar
          const MainAppBar(isChatbotScreen: true),
          verticalSpace(20),
          CustomTextFormField(
            labelText: 'Enter Car Make',
            controller: widget.carPriceForm.carMakeController,
          ),
          verticalSpace(12),
          CustomTextFormField(
            labelText: 'Enter Car Model',
            controller: widget.carPriceForm.carModelController,
          ),
          verticalSpace(12),
          CustomTextFormField(
            labelText: 'Enter Year',
            keyboardType: TextInputType.number,
            controller: widget.carPriceForm.yearController,
          ),
          verticalSpace(12),
          CustomTextFormField(
            labelText: 'Enter Millage',
            keyboardType: TextInputType.number,
            controller: widget.carPriceForm.millageController,
          ),
          verticalSpace(12),
          CustomTextFormField(
            labelText: 'Enter City',
            controller: widget.carPriceForm.cityController,
          ),
          verticalSpace(12),
          // optional features
          SwitchListTile(
            title: CustomText(
              text: 'Automatic Transmission',
              style: getMediumStyle(
                color: context.secondaryColor,
                fontSize: 16,
              ),
            ),
            value: widget.carPriceForm.isAutomaticTransmission,
            onChanged: (value) {
              setState(() {
                widget.carPriceForm.isAutomaticTransmission = value;
              });
            },
          ),
          SwitchListTile(
            title: CustomText(
              text: 'Remote Control',
              style: getMediumStyle(
                color: context.secondaryColor,
                fontSize: 16,
              ),
            ),
            value: widget.carPriceForm.isRemoteControl,
            onChanged: (value) {
              setState(() {
                widget.carPriceForm.isRemoteControl = value;
              });
            },
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CheckboxListTile(
                  checkboxScaleFactor: 1.2,
                  value: widget.carPriceForm.isAirConditioner,
                  onChanged: (value) {
                    setState(() {
                      widget.carPriceForm.isAirConditioner = value!;
                    });
                  },
                  title: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomText(
                      text: 'Air Conditioner',
                      style: getMediumStyle(
                        color: context.secondaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: CheckboxListTile(
                  checkboxScaleFactor: 1.2,
                  value: widget.carPriceForm.isPowerSteering,
                  onChanged: (value) {
                    setState(() {
                      widget.carPriceForm.isPowerSteering = value!;
                    });
                  },
                  title: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomText(
                      text: 'Power Steering ',
                      style: getMediumStyle(
                        color: context.secondaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
