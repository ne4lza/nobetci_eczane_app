class DistrictModel {
  final String districtName;
  final String slug;

  DistrictModel({required this.districtName, required this.slug});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      districtName: json['cities'],
      slug: json['slug'],
    );
  }
}