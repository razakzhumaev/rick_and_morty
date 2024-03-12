class LocationResult {
  final Info? info;
  final List<LocationModel>? results;

  LocationResult({
    this.info,
    this.results,
  });

  factory LocationResult.fromJson(Map<String, dynamic> json) => LocationResult(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<LocationModel>.from(
                json["results"]!.map((x) => LocationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Info {
  final int? count;
  final int? pages;
  final String? next;
  final dynamic prev;

  Info({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
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

class LocationModel {
  final String? imageUrl;
  final int? id;
  final String? name;
  final String? type;
  final String? dimension;
  final List<String>? residents;
  final String? url;
  final DateTime? created;

  LocationModel({
    this.imageUrl,
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.residents,
    this.url,
    this.created,
  });

  static final List<String> imageUrls = [
    'assets/images/planet.png',
    'assets/images/pluton.png',
    'assets/images/picture.png',
    'assets/images/redplanet.png',
    'assets/images/planetstone.png',
    'assets/images/spaceplanet.png',
    'assets/images/therock.png',
    'assets/images/photo1.png',
    'assets/images/picture1.png',
    'assets/images/photo2.png',
    'assets/images/bigplanet.png',
    'assets/images/picture5.jpg',
  ];

  static int _counter = 0;

  static String getNextImageUrl() {
    final imageUrl = imageUrls[_counter];
    _counter = (_counter + 1) % imageUrls.length;
    return imageUrl;
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      dimension: json["dimension"],
      residents: json["residents"] == null
          ? []
          : List<String>.from(json["residents"]!.map((x) => x)),
      url: json["url"],
      created: json["created"] == null ? null : DateTime.parse(json["created"]),
      imageUrl: getNextImageUrl(),
    );
  }

  // Остальной код остается без изменений
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "residents": residents == null
            ? []
            : List<dynamic>.from(residents!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}
