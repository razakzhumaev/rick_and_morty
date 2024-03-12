import 'package:rick_morty_app/features/episodes/data/model/episode_model.dart';

abstract class EpisodeRepository {
  Future<EpisodeResult> getAllEpisodes(int page);
}
