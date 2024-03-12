import 'package:rick_morty_app/features/episodes/data/model/episode_model.dart';
import 'package:rick_morty_app/features/persons/data/model/person_model.dart';
import 'package:rick_morty_app/features/persons/domain/repository/person_repository.dart';

class PersonUseCase {
  final PersonRepository personRepository;

  PersonUseCase({required this.personRepository});

  Future<PersonResult> getAllPersons(int page, {String? name}) async =>
      await personRepository.getAllPersons(page, name: name);

  Future<List<EpisodeModel>> getEpisode(PersonModel personModel) async =>
      await personRepository.getEpisode(personModel);
}
