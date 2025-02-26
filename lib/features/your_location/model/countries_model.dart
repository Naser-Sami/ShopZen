class CountryModel {
  String? country;
  List<String>? cities;

  CountryModel({
    this.country,
    this.cities,
  });

  // from json
  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        country: json["country"],
        cities: json["cities"] == null
            ? []
            : List<String>.from(json["cities"]!.map((x) => x)),
      );

  // to json
  Map<String, dynamic> toJson() => {
        "country": country,
        "cities": cities == null ? [] : List<dynamic>.from(cities!.map((x) => x)),
      };
}
