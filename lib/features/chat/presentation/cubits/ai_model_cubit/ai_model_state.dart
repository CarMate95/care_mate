part of 'ai_model_cubit.dart';

sealed class AiModelState {}

final class AiModelInitial extends AiModelState {}

final class AiModelLoading extends AiModelState {}

final class AiModelSuccess extends AiModelState {
  final String message;
  AiModelSuccess({required this.message});
}

final class AiModelError extends AiModelState {
  final String message;
  AiModelError({required this.message});
}
