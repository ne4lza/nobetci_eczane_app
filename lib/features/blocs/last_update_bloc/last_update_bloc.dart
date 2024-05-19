// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nobetci_eczane/features/models/last_update_model.dart';
import 'package:nobetci_eczane/features/services/last_update_service/last_update_service.dart';

part 'last_update_event.dart';
part 'last_update_state.dart';

class LastUpdateBloc extends Bloc<LastUpdateEvent, LastUpdateState> {
  final LastUpdateService lastUpdateService;
  LastUpdateBloc(this.lastUpdateService) : super(LastUpdateInitial()) {
    on<LastUpdateEvent>((event, emit) async {
      if(event is LoadLastUpdateDate){
        emit(LoadingLastUpdateDate());
        var data = await lastUpdateService.getLastUpdateDate();
        emit(LoadedLastUpdateDate(data));
      }
    });
  }
}
