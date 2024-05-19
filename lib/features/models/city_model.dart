class CityModel {
  final String cities;
  final String slug;

  CityModel({
    required this.cities,
    required this.slug,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cities: json['cities'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cities': cities,
      'slug': slug,
    };
  }
}