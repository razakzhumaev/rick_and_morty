part of 'global_localization_bloc.dart';

@immutable
sealed class GlobalLocalizationEvent {}

class ChangeLocaleEvent extends GlobalLocalizationEvent {
  final String locale;

  ChangeLocaleEvent({required this.locale});
}
