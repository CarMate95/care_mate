import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/functions/kprint.dart';

part 'verify_otp_states.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(VerifyOtpInitialState());

  static VerifyOtpCubit of(context) => BlocProvider.of<VerifyOtpCubit>(context);

  int counter = 0;
  Timer? _timer;

  void startTimer() {
    stopTimer();

    counter = 120; // 2 minutes

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (counter > 0) {
          counter--;
          emit(TimerState());
        } else {
          stopTimer();
        }
      },
    );
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
      counter = 0;
      kprint("Timer Cancelled");
      emit(TimerState());
    }
  }

}
