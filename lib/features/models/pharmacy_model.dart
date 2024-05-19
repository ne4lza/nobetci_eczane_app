class PharmacyModel {
  final int pharmacyID;
  final String pharmacyName;
  final String address;
  final String city;
  final String district;
  final String? town; // İlçeye bağlı olarak bir kasaba veya mahalle olabilir
  final String? directions; // Yön bilgisi, isteğe bağlı
  final String phone;
  final String? phone2; // İkinci telefon numarası, isteğe bağlı
  final String? pharmacyDutyStart; // Eczane nöbet başlangıç saati, isteğe bağlı
  final String? pharmacyDutyEnd; // Eczane nöbet bitiş saati, isteğe bağlı
  final double latitude; // Enlem bilgisi
  final double longitude; // Boylam bilgisi

  PharmacyModel({
    required this.pharmacyID,
    required this.pharmacyName,
    required this.address,
    required this.city,
    required this.district,
    this.town,
    this.directions,
    required this.phone,
    this.phone2,
    this.pharmacyDutyStart,
    this.pharmacyDutyEnd,
    required this.latitude,
    required this.longitude,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      pharmacyID: json['pharmacyID'] ?? 0,
      pharmacyName: json['pharmacyName'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      district: json['district'] ?? '',
      town: json['town'],
      directions: json['directions'],
      phone: json['phone'] ?? '',
      phone2: json['phone2'],
      pharmacyDutyStart: json['pharmacyDutyStart'],
      pharmacyDutyEnd: json['pharmacyDutyEnd'],
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }
}
