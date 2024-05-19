// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nobetci_eczane/features/blocs/city_district/city/city_bloc.dart';
import 'package:nobetci_eczane/features/blocs/city_district/district/district_bloc.dart';
import 'package:nobetci_eczane/features/blocs/last_update_bloc/last_update_bloc.dart';
import 'package:nobetci_eczane/features/blocs/pharmacy_bloc/pharmacy_bloc.dart';
import 'package:nobetci_eczane/features/models/city_model.dart';
import 'package:nobetci_eczane/features/models/district_model.dart';
import 'package:nobetci_eczane/features/models/last_update_model.dart';
import 'package:nobetci_eczane/features/models/pharmacy_model.dart';

class Home extends StatefulWidget {
  
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
  
class _HomeState extends State<Home> {
  late final DistrictBloc _districtBloc;
  @override
  void initState() {
     _districtBloc = BlocProvider.of<DistrictBloc>(context);
    super.initState();
    
  }
  CityModel? selectedCity;
  DistrictModel? selectedDistrict;
  @override
  Widget build(BuildContext context) {
    String _formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(dateTime);
  }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background, // AppBar arka plan rengi
          title: Text('Nöbetçi Eczaneler'), // AppBar başlığı// Başlığı ortalar
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           BlocBuilder<LastUpdateBloc,LastUpdateState>(
            builder: (context, state) {
              if(state is LoadingLastUpdateDate){
                return const Center(child: CircularProgressIndicator());
              }
              if(state is LoadedLastUpdateDate){
                return  Text(
              'SON GÜNCELLENME TARİHİ : ${_formatDate(state.data.data.lastUpdated)}',
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
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                Column(
                  children: [
                    const Text('Lütfen Bir İl Seçiniz*'),
            const SizedBox(height: 5,),
            Container(
              padding: const EdgeInsets.only(left: 16,right: 16),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: BlocBuilder<CityBloc,CityState>(
                builder: (context, state) {
                  if(state is LoadedCities){
                     List<CityModel> cityList = state.cities;
                    return DropdownButton<CityModel>(
                    hint: const Text('Bir Şehir Seçin'),
                    value: selectedCity,
                    onChanged: (CityModel? newValue) {
                    setState(() {
                    selectedCity = newValue!;
                    _districtBloc.add(LoadDistricts(newValue.slug.toString()));
                      });
                    },
                    items: cityList.map((CityModel city) {
                    return DropdownMenuItem<CityModel>(
                    value: city,
                    child: Text(city.cities),
                    );
                    }).toList(),
                    );
                  }
                  if(state is FailedLoadCities){
                    return Text(state.error.toString());
                  }
                  return const SizedBox();
                },
              ),
              ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    const Text('Lütfen Bir İlçe Seçiniz'),
            const SizedBox(height: 5,),
            Container(
              padding: const EdgeInsets.only(left: 16,right: 16),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: BlocBuilder<DistrictBloc,DistrictState>(
                builder: (context, state) {
                  if(state is LoadedDistricts){
                     List<DistrictModel> districtList = state.districts;
                    return DropdownButton<DistrictModel>(
                    hint: const Text('Bir İlçe Seçin'),
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
                    );
                  }
                  if(state is FailedLoadDistricts){
                    return Text(state.error.toString());
                  }
                  return const SizedBox();
                },
              ),
              ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () => BlocProvider.of<PharmacyBloc>(context).add(LoadPharmacies(selectedCity!.slug, selectedDistrict?.slug ?? "")), 
                child: Text(
                  'Sonuçları Getir',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary
                ),
              
              )),
              const SizedBox(height: 30,),
              BlocBuilder<PharmacyBloc,PharmacyState>(
                builder: (context, state) {
                  if(state is NotLoaded){
                    return const Text(
                      'Bir Arama Yapın'
                    );
                  }
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
              )
              
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
          zoomControlsEnabled: false,
          liteModeEnabled: true,
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