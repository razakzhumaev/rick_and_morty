part of 'person_bloc.dart';

@immutable
abstract class PersonState {}

final class PersonInitialState extends PersonState {}

final class PersonLoadingState extends PersonState {}

final class PersonLoadedState extends PersonState {
  final PersonResult personResult;
  final bool isSearch;

  PersonLoadedState({
    required this.personResult,
    required this.isSearch,
  });
}

final class PersonErrorState extends PersonState {
  final CatchException error;

  PersonErrorState({required this.error});
}

class EpisodeLoadedState extends PersonState {
  final List<EpisodeModel> personEpisodeModel;

  EpisodeLoadedState({required this.personEpisodeModel});
}

final class EpisodeLoadingState extends PersonState {}
