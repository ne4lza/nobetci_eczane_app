import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:nobetci_eczane/features/models/city_model.dart';
import 'package:nobetci_eczane/features/services/city_district_service/city_district_service.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityDistrictService cityDistrictService;
  CityBloc(this.cityDistrictService) : super(CityInitial()) {
    on<CityEvent>((event, emit) async {
     if (event is LoadCtites) {
       emit(LoadingCities());
       try {
         final cities = await cityDistrictService.getCities();
        emit(LoadedCities(cities));
       } catch (e) {
         emit(FailedLoadCities(e.toString()));
         print(e.toString());
       }
     }
    });
  }
}
