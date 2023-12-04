
// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ontas_smartwatch/environment/environment.dart';

class ApiService {

  String apiUrl = Environment.API_URL;


  // ***************************************************************
  // SMARTWATCH

  Future<Map<String, dynamic>?> getSmartwatchByToken({
    required String smartwatchToken
  }) async {
    try {

      final response = await http.get(
        Uri.parse('$apiUrl/smartwatch/token/all?token=$smartwatchToken')
      );

      final data = jsonDecode(response.body)[0];
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return data;
      return null;

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>?> getSmartwatchById({
    required int smartwatchId
  }) async {
    try {

      final response = await http.get(
        Uri.parse('$apiUrl/smartwatch/$smartwatchId')
      );

      final data = jsonDecode(response.body);
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return data;
      return null;

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> postSmartwatch({
    required Map<String, dynamic> smartwatchData
  }) async {
    try {

      final response = await http.post(
        Uri.parse('$apiUrl/smartwatch'),
        headers: {'Content-Type': 'application/json'},
        body: smartwatchData
      );

      final data = jsonDecode(response.body);
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return true;
      return false;

    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> patchSmartwatch({
    required int smartwatchId,
    required Map<String, dynamic> smartwatchData
  }) async {
    try {

      final response = await http.patch(
        Uri.parse('$apiUrl/smartwatch/$smartwatchId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(smartwatchData)
      );

      final data = jsonDecode(response.body);
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return true;
      return false;

    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteSmartwatch({
    required int smartwatchId
  }) async {
    try {

      final response = await http.delete(
        Uri.parse('$apiUrl/smartwatch/$smartwatchId'),
      );

      final data = jsonDecode(response.body);
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return true;
      return false;

    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // ***************************************************************
  // SMARTPHONE

  Future<Map<String, dynamic>?> getSmartphoneById({
    required int smartphoneId
  }) async {
    try {

      final response = await http.get(
        Uri.parse('$apiUrl/smartphone/$smartphoneId'),
      );

      final data = jsonDecode(response.body);
      // print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return data;
      return null;

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> postSmartphone({
    required Map<String, dynamic> smartphoneData
  }) async {
    try {

      final response = await http.post(
        Uri.parse('$apiUrl/smartphone'),
        headers: {'Content-Type': 'application/json'},
        body: smartphoneData
      );

      final data = jsonDecode(response.body);
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return true;
      return false;

    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> patchSmartphone({
    required int smartphoneId,
    required Map<String, dynamic> smartphoneData
  }) async {
    try {

      final response = await http.patch(
        Uri.parse('$apiUrl/smartphone/$smartphoneId'),
        headers: {'Content-Type': 'application/json'},
        body: smartphoneData
      );

      final data = jsonDecode(response.body);
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return true;
      return false;

    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteSmartphone({
    required int smartphoneId
  }) async {
    try {

      final response = await http.delete(
        Uri.parse('$apiUrl/smartphone/$smartphoneId'),
      );

      final data = jsonDecode(response.body);
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return true;
      return false;

    } catch (e) {
      print(e.toString());
      return false;
    }
  }
  

}
