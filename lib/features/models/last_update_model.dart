class PharmacyStatus {
  final String status;
  final String message;
  final String messageTR;
  final int systemTime;
  final String endpoint;
  final int rowCount;
  final int creditUsed;
  final Data data;

  PharmacyStatus({
    required this.status,
    required this.message,
    required this.messageTR,
    required this.systemTime,
    required this.endpoint,
    required this.rowCount,
    required this.creditUsed,
    required this.data,
  });

  factory PharmacyStatus.fromJson(Map<String, dynamic> json) {
    return PharmacyStatus(
      status: json['status'],
      message: json['message'],
      messageTR: json['messageTR'],
      systemTime: json['systemTime'],
      endpoint: json['endpoint'],
      rowCount: json['rowCount'],
      creditUsed: json['creditUsed'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'messageTR': messageTR,
      'systemTime': systemTime,
      'endpoint': endpoint,
      'rowCount': rowCount,
      'creditUsed': creditUsed,
      'data': data.toJson(),
    };
  }
}

class Data {
  final String lastUpdated;

  Data({required this.lastUpdated});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      lastUpdated: json['lastupdated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastupdated': lastUpdated,
    };
  }
}
