class CarPriceParams {
  final int millage;
  final int age;
  final String carMake;
  final String carModel;
  final String city;
  final bool isAutomaticTransmission;
  final bool isRemoteControl;
  final bool isAirConditioner;
  final bool isPowerSteering;

  CarPriceParams({
    required this.millage,
    required this.age,
    required this.carMake,
    required this.carModel,
    required this.city,
    required this.isAutomaticTransmission,
    required this.isRemoteControl,
    required this.isAirConditioner,
    required this.isPowerSteering,
  });

  Map<String, dynamic> toMap() {
    return {
      'Mileage': millage,
      'Age': age,
      'Make': carMake,
      'Model': carModel,
      'City': city,
      'Automatic Transmission': isAutomaticTransmission ? 1 : 0,
      'Remote Control': isRemoteControl ? 1 : 0,
      'Air Conditioner': isAirConditioner ? 1 : 0,
      'Power Steering': isPowerSteering ? 1 : 0,
    };
  }
}
