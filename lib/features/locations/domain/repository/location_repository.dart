import 'package:rick_morty_app/features/locations/data/model/location_model.dart';

abstract class LocationRepository {
  Future<LocationResult> getAllLocations(int page);
}
