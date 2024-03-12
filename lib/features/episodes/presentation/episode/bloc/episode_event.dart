part of 'episode_bloc.dart';

@immutable
sealed class EpisodeEvent {}

class GetAllEpisodesEvent extends EpisodeEvent {
  final int currentPage;
  final bool isFirstCall;

  GetAllEpisodesEvent({
    required this.currentPage,
    this.isFirstCall = false,
  });
}
