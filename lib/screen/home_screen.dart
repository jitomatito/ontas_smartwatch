// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ontas_smartwatch/screen/enter_token_screen.dart';
import 'package:ontas_smartwatch/screen/loading_view.dart';
import 'package:ontas_smartwatch/services/api_service.dart';
import 'package:ontas_smartwatch/utils/coordinate.dart';
import 'package:ontas_smartwatch/utils/smartphone.dart';
import 'package:ontas_smartwatch/utils/smartwatch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {

  final int smartwatchId;

  const HomeScreen({
    super.key,
    required this.smartwatchId,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isWaitingRequest = true;
  Smartwatch? smartwatch;
  Smartphone? smartphone;

  @override
  void initState() {
    super.initState();

    getSmartwatchDetails(
      smartwatchId: widget.smartwatchId
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /* Positioned.fill(
            child: Image.asset(
              'assets/justLogo.png',
              fit: BoxFit.cover,
            ),
          ), */

          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [

                  
                  if (isWaitingRequest)
                    const LoadingView(),

                  if (!isWaitingRequest && smartwatch != null && smartphone != null)
                    HomeView(
                      smartwatch: smartwatch!,
                      smartphone: smartphone!,
                    ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future<void> getSmartwatchDetails({
    required int smartwatchId
  }) async {

    final apiService = ApiService();

    final smartwatchData = await apiService.getSmartwatchById(
      smartwatchId: smartwatchId
    );

    // MOCK
    /* final smartwatchData = {
      "id": 23,
      "smartphoneId": 12,
      "childName": 'Pepito',
      "currentLat": 21.6512,
      "currentLong": -104.4316,
      "referenceLat": 20.6512, // casa de sari
      "referenceLong": -103.4316, // casa de sari
      "maxRadio": 500, // mts
      "token": 'RtYzZN',
    }; */

    if (smartwatchData != null /* true */) {

      Smartwatch smartwatchModel = Smartwatch.fromJson(smartwatchData);
    
      final smartphoneData = await apiService.getSmartphoneById(
        smartphoneId: smartwatchModel.smartphoneId
      );

      // MOCK
      /* final smartphoneData = {
        "id": 55,
        "phoneNumber": "3323234545",
      }; */

      if (smartphoneData != null /* true */) {

        Smartphone smartphoneModel = Smartphone.fromJson(smartphoneData);

        setState(() {
          isWaitingRequest = false;
          smartphone = smartphoneModel;
          smartwatch = smartwatchModel;
        });

      }

    }

  }

}

// ----------------------------------------------------------------------------------------

class HomeView extends StatefulWidget {

  final Smartwatch smartwatch;
  final Smartphone smartphone;

  const HomeView({
    super.key,
    required this.smartwatch,
    required this.smartphone,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  static const platform = MethodChannel('com.ontas/locations');

  Coordinate? currentCoordinate;

  @override
  void initState() {
    super.initState();

    _startGeolocalization();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: Column(
        children: [

          const SizedBox(height: 20),

          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.width - 40.0,
              viewportFraction: 1.2,
            ),
            items: List.generate(4, (index) => index).map((int index) {

              return Container(
                width: MediaQuery.of(context).size.width - 40.0,
                height: MediaQuery.of(context).size.width - 40.0,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: getContentSlideCarousel(index)
              );

            }).toList(),
          ),

          const SizedBox(height: 50),

          ElevatedButton(
            onPressed: _unpairSmartwatch, 
            child: const Text(
              "Desvincular",
              style: TextStyle(
                fontSize: 18
              ),
            )
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height / 2 - 70.0 / 2,
          ),

        ],
      ),
    );
  }

  getContentSlideCarousel(int index) {

    if (index == 0) {

      return SizedBox(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              "Número del padre/madre de familia", 
              textAlign: TextAlign.center, maxLines: 1,
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 10),
            Text(
              widget.smartphone.phoneNumber, 
              textAlign: TextAlign.center, maxLines: 1,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      );
    }
    else if (index == 1) {

      return SizedBox(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              "Nombre del niño", 
              textAlign: TextAlign.center, maxLines: 1,
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 10),
            Text(
              widget.smartwatch.childName, 
              textAlign: TextAlign.center, maxLines: 1,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      );
    }
    else if (index == 2) {
      if (currentCoordinate == null) {
        return const Text("- Sin coordenadas -");
      }

      return SizedBox(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              "Latitud: ${double.parse(currentCoordinate!.latitude.toStringAsFixed(4))}", 
              textAlign: TextAlign.center, maxLines: 1,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 10),
            Text(
              "Longitud: ${double.parse(currentCoordinate!.longitude.toStringAsFixed(4))}", 
              textAlign: TextAlign.center, maxLines: 1,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      );
    }
    else {

      return SizedBox(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              "id smartwatch", 
              textAlign: TextAlign.center, maxLines: 1,
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 10),
            Text(
              widget.smartwatch.id.toString(), 
              textAlign: TextAlign.center, maxLines: 1,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      );
    }
    
  }

  void _unpairSmartwatch() async {

    final prefs = await SharedPreferences.getInstance();
    final smartwatchId = prefs.getInt('smartwatchId');

    if (smartwatchId != null) {

      Map<String, dynamic> smartwatchLike = widget.smartwatch.toJson();
      smartwatchLike.update('active', (value) => 0);

      final success = await ApiService().patchSmartwatch(
        smartwatchId: widget.smartwatch.id, 
        smartwatchData: smartwatchLike
      );

      // MOCK
      /* const success = true; */

      if (success) {

        await prefs.remove("smartwatchId");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const EnterTokenScreen()
          ),
        );

      }
    }

  }

  void _startGeolocalization() async {
    platform.setMethodCallHandler(_handlePlatformMethod);

    await platform.invokeMethod('startLocationService');
  }

  Future<void> _handlePlatformMethod(MethodCall call) async {
    switch (call.method) {
      case "locationUpdate":

        dynamic coordinates = call.arguments;

        final double latitude = coordinates["latitude"];
        final double longitude = coordinates["longitude"];

        print("- - - - - - - - - - - - - - - - - - - - - - -");
        print("Coordinates obtained from Kotlin: ");
        print("* Latitude: $latitude");
        print("* Longitude: $longitude");
        print("- - - - - - - - - - - - - - - - - - - - - - -");

        currentCoordinate = Coordinate(
          latitude: latitude, 
          longitude: longitude
        );

        setState(() { });

        // sendToApi();

        break;
      default:
        print('Method not implemented.');
    }
  }

  sendToApi() async {

    Map<String, dynamic> smartwatchLike = widget.smartwatch.toJson();
    smartwatchLike.update('currentLat', (value) => currentCoordinate?.latitude);
    smartwatchLike.update('currentLong', (value) => currentCoordinate?.longitude);

    await ApiService().patchSmartwatch(
      smartwatchId: widget.smartwatch.id, 
      smartwatchData: smartwatchLike
    );

  }


}

