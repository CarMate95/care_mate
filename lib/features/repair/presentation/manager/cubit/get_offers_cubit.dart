import 'package:car_mate/features/repair/data/repo/request_repo_implementation.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetOffersCubit extends Cubit<GetOffersStates> {
  GetOffersCubit(this.offerRepository) : super(GetOffersInitialState());

  final OfferRepositoryImplementation offerRepository;

  Future<void> fetchOffers(int postId) async {
    emit(GetOffersLoadingState());

    var result = await offerRepository.getOffersForPost(postId);

    result.fold(
      (failure) {
        emit(GetOffersFailerState(errorMessage: failure.toString()));
      },
      (offersList) {
        emit(GetOffersSuccessState(offers: offersList));
      },
    );
  }

  Future<void> fetchWinch() async {
    emit(GetWinchLoadingState());

    var result = await offerRepository.fetchWinch();

    result.fold(
      (failure) {
        emit(GetWinchFailureState(errorMessage: failure.message));
      },
      (winchsList) {
        emit(GetWinchSuccessfullyState(winchsList: winchsList));
      },
    );
  }

  Future<void> fetchSessions() async {
    emit(GetSessionsLoadingState());

    var result = await offerRepository.fetchSessions();

    result.fold(
      (failure) {
        emit(GetSessionsFailerState(errorMessage: failure.message));
      },
      (sessionsList) {
        emit(GetSessionsSuccessState(sessionsList: sessionsList));
      },
    );
  }

  Future<void> startSession({
    required int postId,
    required int offerId,
    required String startDate,
  }) async {
    emit(StartSessionLoadingState());

    final result = await offerRepository.sentStartSession(
      postId: postId,
      offerId: offerId,
      startDate: startDate,
    );

    result.fold(
      (error) => emit(StartSessionFailureState(errorMessage: error)),
      (message) => emit(StartSessionSuccessState(message: message)),
    );
  }

  Future<void> endSession({
    required int sessionId,
    required String endDate,
  }) async {
    emit(EndSessionLoadingState());

    final result = await offerRepository.endSession(
      endDate: endDate,
      sessionId: sessionId,
    );

    result.fold(
      (error) => emit(EndSessionFailureState(errorMessage: error)),
      (message) => emit(EndSessionSuccessState(message: message)),
    );
  }
}
