import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rick_morty_app/features/episodes/data/model/episode_model.dart';
import 'package:rick_morty_app/features/persons/data/model/person_model.dart';
import 'package:rick_morty_app/features/persons/domain/repository/person_repository.dart';
import 'package:rick_morty_app/internal/helpers/api_requester.dart';
import 'package:rick_morty_app/internal/helpers/catch_exception.dart';

class PersonRepositoryImpl implements PersonRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<PersonResult> getAllPersons(int page, {String? name}) async {
    try {
      Response response = await apiRequester.toGet(
        'character/',
        params: {
          'page': page,
          'name': name,
        },
      );
      print('getPersonInfo result = ${response.statusCode}');
      log('getPersonInfo result = ${response.data}');

      if (response.statusCode == 200) {
        return PersonResult.fromJson(response.data);
      }
      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  @override
  Future<List<EpisodeModel>> getEpisode(PersonModel personModel) async {
    try {
      List<EpisodeModel> episodeModelList = [];

      for (var element in personModel.episode!) {
        Response response = await apiRequester.toGet(
          'episode/${element.substring(40)}',
        );
        episodeModelList.add(
          EpisodeModel.fromJson(response.data),
        );
      }
      return episodeModelList;
    } catch (e) {
      print('Error: $e');
      throw CatchException.convertException(e);
    }
  }
}
