
// ignore_for_file: avoid_print

import 'package:ontas_smartwatch/environment/environment.dart';
import 'package:dio/dio.dart';

class ApiService {

  String apiUrl = Environment.API_URL;

  late final Dio dio;
  final String accessToken;

  ApiService({
    this.accessToken = ""
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Environment.API_URL,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    )
  );


  // ***************************************************************
  // SMARTWATCH

  Future<Map<String, dynamic>?> getSmartwatchByToken({
    required String smartwatchToken
  }) async {
    try {

      final Response response = await dio.get(
        '/smartwatch/token/$smartwatchToken'
      );

      final data = response.data;
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return data;
      return null;

    } on DioException catch (e) {
      print(e.toString());
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

      final Response response = await dio.get(
        '/smartwatch/$smartwatchId'
      );

      final data = response.data;
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return data;
      return null;

    } on DioException catch (e) {
      print(e.toString());
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

      final Response response = await dio.post(
        '/smartwatch',
        data: smartwatchData
      );

      final data = response.data;
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return true;
      return false;

    } on DioException catch (e) {
      print(e.toString());
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

      final Response response = await dio.patch(
        '/smartwatch/$smartwatchId',
        data: smartwatchData
      );

      final data = response.data;
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return true;
      return false;

    } on DioException catch (e) {
      print(e.toString());
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

      final Response response = await dio.delete(
        '/smartwatch/$smartwatchId'
      );

      final data = response.data;
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return true;
      return false;

    } on DioException catch (e) {
      print(e.toString());
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

      final Response response = await dio.get(
        '/smartphone/$smartphoneId'
      );

      final data = response.data;
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return data;
      return null;

    } on DioException catch (e) {
      print(e.toString());
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

      final Response response = await dio.post(
        '/smartphone',
        data: smartphoneData
      );

      final data = response.data;
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return true;
      return false;

    } on DioException catch (e) {
      print(e.toString());
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

      final Response response = await dio.patch(
        '/smartphone/$smartphoneId',
        data: smartphoneData
      );

      final data = response.data;
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return true;
      return false;

    } on DioException catch (e) {
      print(e.toString());
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

      final Response response = await dio.delete(
        '/smartphone/$smartphoneId'
      );

      final data = response.data;
      print(data);
    
      if (response.statusCode == 200 || response.statusCode == 201) return true;
      return false;

    } on DioException catch (e) {
      print(e.toString());
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
  

}
