// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ontas_smartwatch/screen/home_screen.dart';
import 'package:ontas_smartwatch/services/api_service.dart';
import 'package:ontas_smartwatch/utils/smartwatch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterTokenScreen extends StatefulWidget {

  const EnterTokenScreen({super.key});

  @override
  _EnterTokenScreenState createState() => _EnterTokenScreenState();
}

class _EnterTokenScreenState extends State<EnterTokenScreen> {

  final TextEditingController _smartwatchTokenController = TextEditingController();
  final TextEditingController _childNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    _checkIfAlreadyPaired();
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 90, 114, 247).withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 18, 61, 204).withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  'Ontas',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26
                                  ),
                                ),
                                SizedBox(height: 50),
                                Icon(Icons.arrow_drop_down, color: Colors.black, size: 30), 
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 112, 178, 231),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                'Guarda el nombre del niño',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 140,
                              child: TextField(
                                controller: _childNameController,
                                decoration: InputDecoration(
                                  label: const Text('Nombre', style: TextStyle(fontSize: 12)),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide( 
                                      color: Colors.blue, width: 1.0, 
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            ElevatedButton(
                              onPressed: _saveChildName, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                elevation: 10,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "Guardar",
                                style: TextStyle(
                                  fontSize: 11, color: Colors.white
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 112, 178, 231),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Genera un token de vinculación en la aplicación móvil',
                              textAlign: TextAlign.center,
                            ),
                            Icon(Icons.arrow_drop_down, color: Colors.black, size: 30), 
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 60),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _smartwatchTokenController,
                      decoration: InputDecoration(
                        label: const Text('Token'),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide( 
                            color: Colors.blue, 
                            width: 2.0, 
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.blue, 
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.blue, 
                            width: 2.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: ElevatedButton(
                      onPressed: _pairSmartwatch,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 10,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Vincular',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 24, 68, 230),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_drop_up, color: Colors.white, size: 30), 
                            Text(
                              'Desarrolladores:',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '* Sarahí Salazar',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 11),
                            ),
                            Text(
                              '* Bruno Hernández',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 11),
                            ),
                            Text(
                              '* Jesús Flores',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 11),
                            ),
                            Text(
                              '* Jorge Dávalos',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------- Methods

  void _pairSmartwatch() async {
    try {

      final apiService = ApiService();

      // check if token exists in api
      final smartwatchData = await apiService.getSmartwatchByToken(
        smartwatchToken: _smartwatchTokenController.text
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

      if (smartwatchData != null /* true */) { // if exists

        Smartwatch smartwatch = Smartwatch.fromJson(smartwatchData);

        // mark smartwatch (token) as 'active'
        final success = await apiService.patchSmartwatch(
          smartwatchId: smartwatch.id,
          smartwatchData: {
            "childName": _childNameController.text,
            "active": 1
          }
        );

        // MOCK
        /* const success = true; */

        if (success) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('smartwatchId', smartwatch.id);
          await prefs.setString('childName', _childNameController.text);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                smartwatchId: smartwatch.id,
              ),
            ),
          );
        }
        /* else {
          // 
        } */

      }
      /* else {
        // 
      } */

    } catch (e) {
      // 
    }
  }

  void _saveChildName() async {
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('childName', _childNameController.text);

  }

  Future<void> _checkIfAlreadyPaired() async {

    final prefs = await SharedPreferences.getInstance();
    final smartwatchId = prefs.getInt('smartwatchId'); 

    if (smartwatchId != null) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            smartwatchId: smartwatchId,
          ),
        ),
      );

    }
    else {

      final childName = prefs.getString('childName'); 

      if (childName != null && childName.isNotEmpty) {
        _childNameController.text = childName;
      }

    }

  }


}
