import 'dart:convert';
import 'dart:io';

import 'package:prestaQi/Models/CalculateAdvance.dart';
import 'package:prestaQi/Models/MyAdvanceModel.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RequestAdvanceService {

  String apiUrl;
  Future<SharedPreferences> sPrefs = SharedPreferences.getInstance();

  RequestAdvanceService() {
    this.apiUrl = appService<AppSettings>().apiUrl;
  }

  Future<bool> requestAdvance(double amount) async {
    final SharedPreferences pref = await this.sPrefs;

    final response = await http.post('${this.apiUrl}Advances', body: "{'amount': $amount}", headers: this.headers(pref));
    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success'] as bool) {
        return true;
      }
    }

    return false;
  }

  Future<double> calculateAdvance() async {
    final SharedPreferences pref = await this.sPrefs;

    final response = await http.post('${this.apiUrl}Advances/CalculateAdvance', body: '{}', headers: this.headers(pref));

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success'] as bool) {
        CalculateAdvance responseCalculate = CalculateAdvance.fromJson(responseObject['data']); 

        return responseCalculate.maximumAmount;
      }

      return 1;
    } else {
      return 1;
    }
  }

  Future<CalculateAdvance> calculateAdvanceWithAmount(double amount) async {
    final SharedPreferences pref = await this.sPrefs;

    final response = await http.post('${this.apiUrl}Advances/CalculateAdvance', body: "{'amount': $amount}", headers: this.headers(pref));

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success'] as bool) {
        CalculateAdvance responseCalculate = CalculateAdvance.fromJson(responseObject['data']); 

        return responseCalculate;
      }

      return new CalculateAdvance();
    } else {
      return new CalculateAdvance();
    }
  }

  Future<List<MyAdvanceModel>> getMyAdvances(int userId) async {
    final SharedPreferences pref = await this.sPrefs;
    List<MyAdvanceModel> result = new List<MyAdvanceModel>();
    final response = await http.get('${this.apiUrl}Advances/GetByAccredited/$userId', headers: this.headers(pref));

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success'] as bool) {
        Iterable collection = responseObject['data'] as Iterable;
        result = collection.map((advance) => MyAdvanceModel.fromJson(advance)).toList();
      }
    }

    return result;
  }

  Map<String, String> headers(SharedPreferences pref) {
    return {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString('token')}',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    };
  }
}