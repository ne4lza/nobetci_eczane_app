import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nobetci_eczane/app/app.dart';
import 'package:nobetci_eczane/features/blocs/city_district/city/city_bloc.dart';
import 'package:nobetci_eczane/features/blocs/city_district/district/district_bloc.dart';
import 'package:nobetci_eczane/features/blocs/last_update_bloc/last_update_bloc.dart';
import 'package:nobetci_eczane/features/blocs/pharmacy_bloc/pharmacy_bloc.dart';
import 'package:nobetci_eczane/features/services/city_district_service/city_district_service.dart';
import 'package:nobetci_eczane/features/services/last_update_service/last_update_service.dart';
import 'package:nobetci_eczane/features/services/pharmacy_service/pharmacy_service.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LastUpdateService(),
        ),
        RepositoryProvider(
          create: (context) => CityDistrictService(),
        ),
        RepositoryProvider(
          create: (context) => PharmacyService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
           BlocProvider<LastUpdateBloc>(
            create: (context) => LastUpdateBloc(
              RepositoryProvider.of<LastUpdateService>(context),
            )..add(LoadLastUpdateDate()),
          ),


          BlocProvider<CityBloc>(
            create: (context) => CityBloc(
              RepositoryProvider.of<CityDistrictService>(context),
            )..add(LoadCtites()),
          ),


          BlocProvider<DistrictBloc>(
            create: (context) => DistrictBloc(
              RepositoryProvider.of<CityDistrictService>(context),
            )..add(LoadDistricts("")),
          ),


          BlocProvider<PharmacyBloc>(
            create: (context) => PharmacyBloc(
              RepositoryProvider.of<PharmacyService>(context),
            )..add(LoadPharmacies("", "")),
          ),
        ],
        child: const EczaneApp(),
      )
    )
    );
}