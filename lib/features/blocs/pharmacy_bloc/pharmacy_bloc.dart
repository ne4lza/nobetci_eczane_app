import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nobetci_eczane/features/models/pharmacy_model.dart';
import 'package:nobetci_eczane/features/services/pharmacy_service/pharmacy_service.dart';

part 'pharmacy_event.dart';
part 'pharmacy_state.dart';

class PharmacyBloc extends Bloc<PharmacyEvent, PharmacyState> {
  final PharmacyService pharmacyService;
  PharmacyBloc(this.pharmacyService) : super(PharmacyInitial()) {
    on<PharmacyEvent>((event, emit)  async{
      if(event is LoadPharmacies){
        emit(NotLoaded());
        try {
          emit(LoadingPharmacies());
          final pharmacies = await pharmacyService.getPharmacies(event.city, event.district ?? "");
          emit(LoadedPharmacies(pharmacies));

        } catch (e) {
          emit(FailedLoadPharmacies(e.toString()));
        }
      }
    });
  }
}
