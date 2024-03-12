part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

class GetAllLocationsEvent extends LocationEvent {
  final int currentPage;
  final bool isFirstCall;

  GetAllLocationsEvent({
    required this.currentPage,
    this.isFirstCall = false,
  });
}
