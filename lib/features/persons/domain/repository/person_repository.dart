import 'package:rick_morty_app/features/episodes/data/model/episode_model.dart';
import 'package:rick_morty_app/features/persons/data/model/person_model.dart';

abstract class PersonRepository {

  Future<PersonResult> getAllPersons(int page, {String? name});

  Future<List<EpisodeModel>> getEpisode(PersonModel personModel);
}
