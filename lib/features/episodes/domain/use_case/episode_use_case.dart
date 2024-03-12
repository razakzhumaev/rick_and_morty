import 'package:rick_morty_app/features/episodes/data/model/episode_model.dart';
import 'package:rick_morty_app/features/episodes/domain/repository/episode_repository.dart';

class EpisodeUseCase {
  final EpisodeRepository episodeRepository;

  EpisodeUseCase({required this.episodeRepository});

  Future<EpisodeResult> getAllEpisodes(int page) async =>
      await episodeRepository.getAllEpisodes(page);
}
