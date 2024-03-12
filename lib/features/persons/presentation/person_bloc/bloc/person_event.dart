part of 'person_bloc.dart';

@immutable
sealed class PersonEvent {}

class GetAllPersonsEvent extends PersonEvent {
  final int currentPage;
  final bool isFirstCall;
  final String? name;
  final bool isSearch;

  GetAllPersonsEvent({
    required this.currentPage,
    this.isFirstCall = false,
    this.name,
    this.isSearch = false,
  });
}

class GetPersonEpisodeEvent extends PersonEvent {
  final PersonModel personModel;

  GetPersonEpisodeEvent({required this.personModel});
}
