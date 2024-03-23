import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_app/features/locations/data/model/location_model.dart';
import 'package:rick_morty_app/features/locations/domain/repository/location_repository.dart';
import 'package:rick_morty_app/internal/helpers/api_requester.dart';
import 'package:rick_morty_app/internal/helpers/catch_exception.dart';

class LocationRepositoryImpl implements LocationRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<LocationResult> getAllLocations(int page) async {
    try {
      Response response = await apiRequester.toGet(
        'location/',
        params: {'page': page},
      );
      debugPrint('getAllLocations == ${response.statusCode}');
      log('getAllLocations == ${response.data}');
      
      if (response.statusCode == 200) {
        return LocationResult.fromJson(response.data);
      }
      throw response;
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
