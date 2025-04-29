import 'package:flutter/material.dart';

class CarPriceForm {
  final formKey = GlobalKey<FormState>();
  final carModelController = TextEditingController();
  final yearController = TextEditingController();
  final millageController = TextEditingController();
  final cityController = TextEditingController();
  bool isAutomaticTransmission = false;
  bool isRemoteControl = false;
  bool isAirConditioner = false;
  bool isPowerSteering = false;

  void dispose() {
    carModelController.dispose();
    yearController.dispose();
    millageController.dispose();
    cityController.dispose();
  }
}
