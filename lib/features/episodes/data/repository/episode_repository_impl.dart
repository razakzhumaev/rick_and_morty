import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_app/features/episodes/data/model/episode_model.dart';
import 'package:rick_morty_app/features/episodes/domain/repository/episode_repository.dart';
import 'package:rick_morty_app/internal/helpers/api_requester.dart';
import 'package:rick_morty_app/internal/helpers/catch_exception.dart';

class EpisodeRepositoryImpl implements EpisodeRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<EpisodeResult> getAllEpisodes(page) async {
    try {
      Response response = await apiRequester.toGet(
        'episode',
        params: {'page': page},
      );

      debugPrint('getAllEpisodes == ${response.statusCode}');
      debugPrint('getAllEpisodes == ${response.data}');

      if (response.statusCode == 200) {
        return EpisodeResult.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
