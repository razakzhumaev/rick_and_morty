part of 'global_localization_bloc.dart';

@immutable
sealed class GlobalLocalizationState {}

final class GlobalLocalizationInitialState extends GlobalLocalizationState {}

final class GlobalLocalizationLoadingState extends GlobalLocalizationState {}

final class GlobalLocalizationLoadedState extends GlobalLocalizationState {
  final String locale;

  GlobalLocalizationLoadedState({required this.locale});
}

final class GlobalLocalizationErrorState extends GlobalLocalizationState {
  final CatchException error;

  GlobalLocalizationErrorState({required this.error});
}
