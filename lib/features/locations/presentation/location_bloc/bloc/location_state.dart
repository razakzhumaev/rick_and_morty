part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitialState extends LocationState {}

final class LocationLoadingState extends LocationState {}

final class LocationLoadedState extends LocationState {
  final LocationResult locationResult;

  LocationLoadedState({required this.locationResult});
}

final class LocationErrorState extends LocationState {
  final CatchException error;

  LocationErrorState({required this.error});
}
