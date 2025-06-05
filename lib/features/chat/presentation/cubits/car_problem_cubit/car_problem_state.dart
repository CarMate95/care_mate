part of 'car_problem_cubit.dart';

sealed class CarProblemState {}

final class CarProblemInitial extends CarProblemState {}

final class CarProblemLoading extends CarProblemState {}

final class CarProblemSuccess extends CarProblemState {
  final String problem;
  CarProblemSuccess({required this.problem});
}

final class CarProblemError extends CarProblemState {
  final String message;
  CarProblemError({required this.message});
}
