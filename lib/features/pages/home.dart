// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nobetci_eczane/core/config/app_strings.dart';
import 'package:nobetci_eczane/features/blocs/city_district/district/district_bloc.dart';
import 'package:nobetci_eczane/features/mixin/home_view_mixin.dart';

class Home extends StatefulWidget {
  
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
  
class _HomeState extends State<Home> with HomeViewMixin {
  
  @override
  void initState() {
     districtBloc = BlocProvider.of<DistrictBloc>(context);
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background, // AppBar arka plan rengi
          title: Text(
            AppStrings().pageTitle
          ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(left: 4,right: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //lastUpdate
            lastUpdateBlocBuilder(),
            const SizedBox(height: 30,),
            Row(
              children: [
                Column(
                  children: [
                    //Text(appStrings.citySelectorText),
            const SizedBox(height: 5,),
            Container(
              padding: const EdgeInsets.only(left: 16,right: 16),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              // city bloc
              child: citySelectBlocBuilder(),
              ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    //Text(appStrings.districtSelectorText),
            const SizedBox(height: 5,),
            Container(
              padding: const EdgeInsets.only(left: 16,right: 16),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              //district bloc
              child: districtSelectBlocBuilder(),
              ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () => triggerPharmacyBloc(selectedCity!.slug,selectedDistrict!.slug),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary
                ),
                child: Text(
                  appStrings.buttonText,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  ),
              
              )),
              const SizedBox(height: 30,),
              //pharmacy card
              pharmacyBlocBuilder()
          ],
        ),
      ),
    );
  }
}

class pharmacyCard extends StatelessWidget {
  final String? title;
  final String? address;
  final String? phone;
  final double? latitude;
  final double? longitude;
  const pharmacyCard({
    this.title,
    this.address,
    this.phone,
    this.latitude,
    this.longitude,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                 Expanded(
    flex: 2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toString(),
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on, color: Colors.blue[200]),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                address.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onPrimary,
                  ),
                
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
           Icon(Icons.phone, color: Colors.green[200]),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                phone.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onPrimary,
                  ),
              ),
            ),
          ],
        ),
      ],
    ),
                ),
                const SizedBox(width: 16),
                Expanded(
    flex: 3,
    child: SizedBox(
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(latitude!, longitude!),
            zoom: 14.0,
          ),
          markers: {
            Marker(
              markerId: const MarkerId('Eczane'),
              position: LatLng(latitude!, longitude!),
            ),
          },
          zoomControlsEnabled: true,
          liteModeEnabled: true,
          scrollGesturesEnabled: true,
        ),
      ),
    ),
                ),
              ],
            ),
          ),
        );
  }
}