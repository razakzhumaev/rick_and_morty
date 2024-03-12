// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_morty_app/features/episodes/data/model/episode_model.dart';
import 'package:rick_morty_app/features/episodes/domain/use_case/episode_use_case.dart';
import 'package:rick_morty_app/internal/helpers/catch_exception.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final EpisodeUseCase episodeUseCase;

  EpisodeBloc({required this.episodeUseCase}) : super(EpisodeInitialState()) {
    on<GetAllEpisodesEvent>((event, emit) async {
      try {
        if (event.isFirstCall) {
          emit(EpisodeLoadingState());
        }

        EpisodeResult result =
            await episodeUseCase.getAllEpisodes(event.currentPage);

        emit(EpisodeLoadedState(episodeResult: result));
      } catch (e) {
        emit(EpisodeErrorState(error: CatchException.convertException(e)));
      }
    });
  }
}
