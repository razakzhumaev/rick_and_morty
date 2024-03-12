import 'package:flutter/material.dart';
import 'package:rick_morty_app/features/persons/data/model/person_model.dart';

String statusDeadAliveConverter(Status? status) {
  switch (status) {
    case Status.ALIVE:
      return 'Живой';

    case Status.DEAD:
      return 'Мертвый';

    default:
      return 'Неизвестно';
  }
}

Color statusColorConverter(Status? status) {
  switch (status) {
    case Status.ALIVE:
      return Colors.green;

    case Status.DEAD:
      return Colors.red;

    default:
      return Colors.black;
  }
}

String statusSpeciesConverter(Species? species) {
  switch (species) {
    case Species.ALIEN:
      return 'Инопланетянин';

    case Species.HUMAN:
      return 'Человек';
      
    default:
      return 'Неизвестно';
  }
}

String statusGenderConverter(Gender? gender) {
  switch (gender) {
    case Gender.MALE:
      return 'Мужской';

    case Gender.FEMALE:
      return 'Женский';

    default:
      return 'Неизвестно';
  }
}
