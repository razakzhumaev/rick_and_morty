import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_morty_app/features/episodes/data/model/episode_model.dart';
import 'package:rick_morty_app/features/persons/data/model/person_model.dart';
import 'package:rick_morty_app/features/persons/domain/use_case/person_use_case.dart';
import 'package:rick_morty_app/internal/helpers/catch_exception.dart';
part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonUseCase personUseCase;

  PersonBloc({required this.personUseCase}) : super(PersonInitialState()) {
    
    on<PersonEvent>((event, emit) {});

    on<GetAllPersonsEvent>((event, emit) async {
      try {
        if (event.isFirstCall) {
          emit(PersonLoadingState());
        }

        PersonResult result = await personUseCase
            .getAllPersons(event.currentPage, name: event.name);

        emit(PersonLoadedState(
          personResult: result,
          isSearch: event.isSearch,
        ));
      } catch (e) {
        emit(PersonErrorState(error: CatchException.convertException(e)));
      }
    });

    on<GetPersonEpisodeEvent>((event, emit) async {
      emit(EpisodeLoadingState());

      try {
        List<EpisodeModel> personEpisodeModel =
            await personUseCase.getEpisode(event.personModel);
            
        emit(EpisodeLoadedState(personEpisodeModel: personEpisodeModel));
      } catch (error) {
        emit(PersonErrorState(error: CatchException.convertException(error)));
      }
    });
  }
}
