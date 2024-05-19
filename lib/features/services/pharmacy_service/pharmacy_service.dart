import 'package:dio/dio.dart';
import 'package:nobetci_eczane/core/config/api_constants.dart';
import 'package:nobetci_eczane/features/models/pharmacy_model.dart';

class PharmacyService {

  Future<List<PharmacyModel>> getPharmacies(String city,String district) async {
    final dio = Dio();
    final cityPharmacyListEndPoint = ApiConstants().pharmacyListByCityEndPoint+city;
    final cityDistrictPharmacyListEndPoint = ApiConstants().pharmacyListByCityDistrictEndPoint+"city=${city}&district=${district}";
    final apiKey = ApiConstants().apiKey;
    Response response;
    if(district != ""){
      response = await dio.get(
        cityDistrictPharmacyListEndPoint,
        options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
        }
      )
      );
    }
    else{
       response = await dio.get(
        cityPharmacyListEndPoint,
        options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
        }
      )
      );
    }

    if(response.statusCode == 200){
      final List<dynamic> result = response.data['data'];
      return result.map((e) => PharmacyModel.fromJson(e)).toList();
    }
    else{
      throw Exception();
    }
  }
  
}