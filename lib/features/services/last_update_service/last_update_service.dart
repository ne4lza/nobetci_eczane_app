import 'package:dio/dio.dart';
import 'package:nobetci_eczane/core/config/api_constants.dart';
import 'package:nobetci_eczane/features/models/last_update_model.dart';

class LastUpdateService {

  Future<PharmacyStatus> getLastUpdateDate() async{
    final dio = Dio();
    final String endPoint = ApiConstants().lastUpdateDateEndPoint;
    final String apiKey = ApiConstants().apiKey;

    var response = await dio.get(
      endPoint,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
        }
      )
      );

    if(response.statusCode == 200){
      final data = response.data;
      print(data);
      var lastData = PharmacyStatus.fromJson(data);
      print(lastData.data.lastUpdated);
      return lastData;
      
    }else {
      throw Exception(response.statusMessage);
      
    }
    
  }
  
}