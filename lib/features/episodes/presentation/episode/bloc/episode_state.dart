// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'episode_bloc.dart';

@immutable
sealed class EpisodeState {}

final class EpisodeInitialState extends EpisodeState {}

final class EpisodeLoadingState extends EpisodeState {}

final class EpisodeLoadedState extends EpisodeState {
  final EpisodeResult episodeResult;

  EpisodeLoadedState({required this.episodeResult});
}

final class EpisodeErrorState extends EpisodeState {
  final CatchException error;

  EpisodeErrorState({required this.error});
}
