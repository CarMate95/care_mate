import 'package:car_mate/features/repair/data/models/request_model.dart';
import 'package:car_mate/features/repair/data/models/session_model.dart';
import 'package:car_mate/features/repair/data/models/winch_model.dart';

abstract class GetOffersStates {}

class GetOffersInitialState extends GetOffersStates {}

class GetOffersLoadingState extends GetOffersStates {}

class GetOffersSuccessState extends GetOffersStates {
  List<OfferModel> offers;

  GetOffersSuccessState({
    required this.offers,
  });
}

class GetOffersFailerState extends GetOffersStates {
  final String errorMessage;

  GetOffersFailerState({required this.errorMessage});
}

class GetWinchLoadingState extends GetOffersStates {}

class GetWinchSuccessfullyState extends GetOffersStates {
  final List<WinchModel> winchsList;

  GetWinchSuccessfullyState({required this.winchsList});
}

class GetWinchFailureState extends GetOffersStates {
  final String errorMessage;

  GetWinchFailureState({required this.errorMessage});
}

class GetSessionsLoadingState extends GetOffersStates {}

class GetSessionsSuccessState extends GetOffersStates {
  final List<SessionModel> sessionsList;

  GetSessionsSuccessState({required this.sessionsList});
}

class GetSessionsFailerState extends GetOffersStates {
  final String errorMessage;

  GetSessionsFailerState({required this.errorMessage});
}

class StartSessionLoadingState extends GetOffersStates {}

class StartSessionSuccessState extends GetOffersStates {
  final String message;

  StartSessionSuccessState({required this.message});
}

class StartSessionFailureState extends GetOffersStates {
  final String errorMessage;
  StartSessionFailureState({required this.errorMessage});
}

class EndSessionLoadingState extends GetOffersStates {}

class EndSessionSuccessState extends GetOffersStates {
  final String message;

  EndSessionSuccessState({required this.message});
}

class EndSessionFailureState extends GetOffersStates {
  final String errorMessage;
  EndSessionFailureState({required this.errorMessage});
}
