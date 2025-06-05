import 'package:flutter/material.dart';

class CarPriceForm {
  final formKey = GlobalKey<FormState>();
  final carMakeController = TextEditingController();
  final carModelController = TextEditingController();
  final ageController = TextEditingController();
  final millageController = TextEditingController();
  final cityController = TextEditingController();
  bool isAutomaticTransmission = false;
  bool isRemoteControl = false;
  bool isAirConditioner = false;
  bool isPowerSteering = false;

  void dispose() {
    carModelController.dispose();
    ageController.dispose();
    millageController.dispose();
    cityController.dispose();
  }
}
