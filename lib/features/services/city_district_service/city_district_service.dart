import 'package:dio/dio.dart';
import 'package:nobetci_eczane/core/config/api_constants.dart';
import 'package:nobetci_eczane/features/models/city_model.dart';
import 'package:nobetci_eczane/features/models/district_model.dart';

class CityDistrictService{

  Future<List<CityModel>> getCities() async{
    final dio = Dio();
    final endPoint = ApiConstants().cityListEndPoint;
    final apiKey = ApiConstants().apiKey;

    var response = await dio.get(
      endPoint,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
        }
      )
    );

    if(response.statusCode == 200){
      final List<dynamic> result = response.data['data'];
      return result.map((e) => CityModel.fromJson(e)).toList();
    }
    else{
      throw Exception();
    }
  }

  Future<List<DistrictModel>> getDistricts(String slug) async{
    final dio = Dio();
    final endPoint = ApiConstants().districtListEndPoint+slug;
    final apiKey = ApiConstants().apiKey;

    var response = await dio.get(
      endPoint,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
        }
      )
    );

    if(response.statusCode == 200){
      final List<dynamic> result = response.data['data'];
      return result.map((e) => DistrictModel.fromJson(e)).toList();
    }
    else{
      throw Exception();
    }
  }

}