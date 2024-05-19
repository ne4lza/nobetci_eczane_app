import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> items = ['Adana','Ankara','İstanbul','İzmir','Bursa','Balıkesir','Muğla'];
  String selectedItem = 'Adana';
  @override
  Widget build(BuildContext context) {
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
            const Text(
              'SON GÜNCELLENME TARİHİ :',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
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
              child: DropdownButton<String>(
                hint: const Text('Bir Şehir Seçiniz'),
                dropdownColor: Colors.grey,
                value: selectedItem,
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedItem = newValue;
                    });
                  }
                },
              ),
            ),
                  ],
                ),
                const SizedBox(width: 10),
               Column(
                  children: [
            const Text(
              'Lütfen Bir İlçe Seçiniz',
              ),
            const SizedBox(height: 5,),
            Container(
              padding: const EdgeInsets.only(left: 16,right: 16),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButton<String>(
                hint: const Text('Bir Şehir Seçiniz'),
                dropdownColor: Colors.grey,
                value: selectedItem,
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedItem = newValue;
                    });
                  }
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
                onPressed: () => (), 
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
              Card(
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
                    'Kanuni Eczanesi',
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
                          '1456 sokak no:98\/A Alsancak Konak \/ İzmir',
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
                      Text(
                        '0(232)463-40-86',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onPrimary,
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
              child: Container(
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(41.0082, 28.9784),
                      zoom: 14.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('pharmacyLocation'),
                        position: LatLng(41.0082, 28.9784),
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
    )
              
          ],
        ),
      ),
    );
  }
}