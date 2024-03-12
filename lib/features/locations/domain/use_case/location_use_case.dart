import 'package:rick_morty_app/features/locations/data/model/location_model.dart';
import 'package:rick_morty_app/features/locations/domain/repository/location_repository.dart';

class LocationUseCase {
  final LocationRepository locationRepository;

  LocationUseCase({required this.locationRepository});

  Future<LocationResult> getAllLocations(int page) async =>
      await locationRepository.getAllLocations(page);
}
