import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nobetci_eczane/core/config/app_strings.dart';
import 'package:nobetci_eczane/features/blocs/city_district/city/city_bloc.dart';
import 'package:nobetci_eczane/features/blocs/city_district/district/district_bloc.dart';
import 'package:nobetci_eczane/features/blocs/last_update_bloc/last_update_bloc.dart';
import 'package:nobetci_eczane/features/blocs/pharmacy_bloc/pharmacy_bloc.dart';
import 'package:nobetci_eczane/features/models/city_model.dart';
import 'package:nobetci_eczane/features/models/district_model.dart';
import 'package:nobetci_eczane/features/models/pharmacy_model.dart';
import 'package:nobetci_eczane/features/pages/home.dart';

mixin HomeViewMixin on State<Home>{
  CityModel? selectedCity;
  DistrictModel? selectedDistrict;
  late final DistrictBloc districtBloc;
  final AppStrings appStrings = AppStrings();

  //Son güncellenme tarihi format methodu
  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateFormat formatter = DateFormat('dd.MM.yyyy HH:mm');
    return formatter.format(dateTime);
  }

  //Last Update Bloc
  Widget lastUpdateBlocBuilder(){
    return BlocBuilder<LastUpdateBloc,LastUpdateState>(
            builder: (context, state) {
              if(state is LoadingLastUpdateDate){
                return const Center(child: CircularProgressIndicator());
              }
              if(state is LoadedLastUpdateDate){
                return  Text(
                 '${appStrings.lastUpdateText}'' ${formatDate(state.data.data.lastUpdated)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            );
              }
              if(state is FailedLoadLastUpdateDate){
                return const SizedBox();
              }
              return const SizedBox();
            },
            );
  }

  //city Bloc
  Widget citySelectBlocBuilder(){
    return BlocBuilder<CityBloc,CityState>(
                builder: (context, state) {
                  if(state is LoadedCities){
                     List<CityModel> cityList = state.cities;
                    return Container(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<CityModel>(
                          hint: Text(appStrings.cityDropdownHintText),
                          value: selectedCity,
                          onChanged: (CityModel? newValue) {
                          setState(() {
                          selectedCity = newValue!;
                          districtBloc.add(LoadDistricts(newValue.slug.toString()));
                            });
                          },
                          items: cityList.map((CityModel city) {
                          return DropdownMenuItem<CityModel>(
                          value: city,
                          child: Text(city.cities),
                          );
                          }).toList(),
                          ),
                        ),
                      ),
                    );
                  }
                  if(state is FailedLoadCities){
                    return Text(state.error.toString());
                  }
                  return const SizedBox();
                },
              );
  }

  //district bloc
  Widget districtSelectBlocBuilder(){
    return BlocBuilder<DistrictBloc,DistrictState>(
                builder: (context, state) {
                  if(state is LoadedDistricts){
                     List<DistrictModel> districtList = state.districts;
                    return DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        child: DropdownButton<DistrictModel>(
                        hint:  Text(appStrings.districtDropdownHintText),
                        value: selectedDistrict,
                        onChanged: (DistrictModel? newValue) {
                        setState(() {
                        selectedDistrict = newValue!;
                          });
                        },
                        items: districtList.map((DistrictModel district) {
                        return DropdownMenuItem<DistrictModel>(
                        value: district,
                        child: Text(district.districtName),
                        );
                        }).toList(),
                        ),
                      ),
                    );
                  }
                  if(state is FailedLoadDistricts){
                    return Text(state.error.toString());
                  }
                  return const SizedBox();
                },
              );
  }


  //pharmacy bloc
  Widget pharmacyBlocBuilder(){
    return BlocBuilder<PharmacyBloc,PharmacyState>(
                builder: (context, state) {
                  if(state is LoadingPharmacies){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(state is LoadedPharmacies){
                    List<PharmacyModel> pharmacyList = state.pharmacyList;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: pharmacyList.length,
                        itemBuilder: (context, index) {
                          return pharmacyCard(
                            title: pharmacyList[index].pharmacyName,
                            address: pharmacyList[index].address,
                            phone: pharmacyList[index].phone,
                            latitude: pharmacyList[index].latitude,
                            longitude: pharmacyList[index].longitude,
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              );
  }


  //sonuçları getir butonu
  void triggerPharmacyBloc(String city,String? district) {
    BlocProvider.of<PharmacyBloc>(context).add(LoadPharmacies(city, district ?? ""));
  }
}