import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_morty_app/internal/helpers/catch_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'global_localization_event.dart';
part 'global_localization_state.dart';

class GlobalLocalizationBloc
    extends Bloc<GlobalLocalizationEvent, GlobalLocalizationState> {
  GlobalLocalizationBloc() : super(GlobalLocalizationInitialState()) {
    on<ChangeLocaleEvent>((event, emit) async {
      emit(GlobalLocalizationLoadingState());
      try {
        setCurrentLocale(currentLocale: event.locale);

        String currentLocale = await getCurrentLocale();

        emit(GlobalLocalizationLoadedState(locale: currentLocale));
      } catch (e) {
        emit(
          GlobalLocalizationErrorState(
            error: CatchException.convertException(e),
          ),
        );
      }
    });
  }
}

Future<void> setCurrentLocale({required String currentLocale}) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('locale', currentLocale);
}

Future<String> getCurrentLocale() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String value = preferences.getString('locale') ?? 'ru';
  return value;
}
