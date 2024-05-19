import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nobetci_eczane/features/models/district_model.dart';
import 'package:nobetci_eczane/features/services/city_district_service/city_district_service.dart';

part 'district_event.dart';
part 'district_state.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  final CityDistrictService cityDistrictService;
  DistrictBloc(this.cityDistrictService) : super(DistrictInitial()) {
    on<DistrictEvent>((event, emit) async {
     if (event is LoadDistricts) {
       emit(LoadingDistricts());
       try {
         final districts = await cityDistrictService.getDistricts(event.cityName);
        emit(LoadedDistricts(districts));
       } catch (e) {
         emit(FailedLoadDistricts(e.toString()));
         print(e.toString());
       }
     }
    });
  }
}
