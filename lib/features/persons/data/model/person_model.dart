class PersonResult {
  final PersonInfo? info;
  final List<PersonModel>? results;

  PersonResult({
    this.info,
    this.results,
  });

  factory PersonResult.fromJson(Map<String, dynamic> json) => PersonResult(
        info: json["info"] == null ? null : PersonInfo.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<PersonModel>.from(
                json["results"]!.map((x) => PersonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class PersonInfo {
  final int? count;
  final int? pages;
  final String? next;
  final dynamic prev;

  PersonInfo({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  factory PersonInfo.fromJson(Map<String, dynamic> json) => PersonInfo(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class PersonModel {
  final int? id;
  final String? name;
  final Status? status;
  final Species? species;
  final String? type;
  final Gender? gender;
  final Location? origin;
  final Location? location;
  final String? image;
  final List<String>? episode;
  final String? url;
  final DateTime? created;

  PersonModel({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]] ?? Status.UNKNOWN,
        species: speciesValues.map[json["species"]] ?? Species.UNKNOWN,
        type: json["type"],
        gender: genderValues.map[json["gender"]] ?? Gender.UNKNOWN,
        origin:
            json["origin"] == null ? null : Location.fromJson(json["origin"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        image: json["image"],
        episode: json["episode"] == null
            ? []
            : List<String>.from(json["episode"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin?.toJson(),
        "location": location?.toJson(),
        "image": image,
        "episode":
            episode == null ? [] : List<dynamic>.from(episode!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}

enum Gender { FEMALE, MALE, UNKNOWN }

final genderValues = EnumValues(
  {"Female": Gender.FEMALE, "Male": Gender.MALE, "Unknown": Gender.UNKNOWN},
);

class Location {
  final String? name;
  final String? url;

  Location({
    this.name,
    this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

enum Species { ALIEN, HUMAN, UNKNOWN }

final speciesValues = EnumValues(
  {"Alien": Species.ALIEN, "Human": Species.HUMAN},
);

enum Status { ALIVE, DEAD, UNKNOWN }

final statusValues = EnumValues(
  {"Alive": Status.ALIVE, "Dead": Status.DEAD, "Unknown": Status.UNKNOWN},
);

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
