class ApiConstants {
  String apiKey = "3K6dzZ9Chn526neVbPr2M4TBEcwLrEluiYmUxFiPxqrjb1cPsVCR1TBpb8d6";
  String lastUpdateDateEndPoint = "https://www.nosyapi.com/apiv2/service/pharmacies-on-duty/status";
  String cityListEndPoint ="https://www.nosyapi.com/apiv2/service/pharmacies-on-duty/cities";

  //DIŞARDAN ŞEHİR PARAMETRESİ VERİLEREK ÇALIŞTIRILIR
  String districtListEndPoint = "https://www.nosyapi.com/apiv2/service/pharmacies-on-duty/cities?city=";
  String pharmacyListByCityEndPoint = "https://www.nosyapi.com/apiv2/service/pharmacies-on-duty?city=";

  //DIŞARDAN ŞEHİR VE İLÇE PARAMETRESİ VERİLEREK ÇALIŞTIRILIR 
  //city=izmir&district=konak
  String pharmacyListByCityDistrictEndPoint = "https://www.nosyapi.com/apiv2/service/pharmacies-on-duty?";
}