import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_morty_app/features/locations/data/model/location_model.dart';
import 'package:rick_morty_app/features/locations/domain/use_case/location_use_case.dart';
import 'package:rick_morty_app/internal/helpers/catch_exception.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationUseCase locationUseCase;
  LocationBloc({required this.locationUseCase})
      : super(LocationInitialState()) {
    on<GetAllLocationsEvent>((event, emit) async {
      try {
        if (event.isFirstCall) {
          emit(LocationLoadingState());
        }
        LocationResult result =
            await locationUseCase.getAllLocations(event.currentPage);

        emit(LocationLoadedState(locationResult: result));
      } catch (e) {
        emit(LocationErrorState(error: CatchException.convertException(e)));
      }
    });
  }
}
