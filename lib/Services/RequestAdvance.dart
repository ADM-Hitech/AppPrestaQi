import 'dart:convert';
import 'dart:io';

import 'package:prestaQi/Models/DatesPeriod.dart';
import 'package:prestaQi/Models/PreAdvance.dart';
import 'package:prestaQi/Models/RegisterAdvances.dart';
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

    Uri url = appService<AppSettings>().envProd ? new Uri.https(this.apiUrl, '/api/Advances') : new Uri.http(this.apiUrl, '/api/Advances');

    final response = await http.post(url, body: "{'amount': $amount}", headers: this.headers(pref));
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

    Uri url = appService<AppSettings>().envProd ? new Uri.https(this.apiUrl, '/api/Advances/CalculateAdvance') : new Uri.http(this.apiUrl, '/api/Advances/CalculateAdvance');

    final response = await http.post(url, body: '{}', headers: this.headers(pref));

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success'] as bool) {
        PreAdvance responseCalculate = PreAdvance.fromJson(responseObject['data']); 

        return responseCalculate.advance.maximunAmount;
      }

      return 1;
    } else {
      return 1;
    }
  }

  Future<PreAdvance> calculateAdvanceWithAmount(double amount) async {
    final SharedPreferences pref = await this.sPrefs;

    Uri url = appService<AppSettings>().envProd ? new Uri.https(this.apiUrl, '/api/Advances/CalculateAdvance') : new Uri.http(this.apiUrl, '/api/Advances/CalculateAdvance');

    final response = await http.post(url, body: "{'amount': $amount}", headers: this.headers(pref));

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success'] as bool) {
        PreAdvance responseCalculate = PreAdvance.fromJson(responseObject['data']); 

        return responseCalculate;
      }

      return new PreAdvance();
    } else {
      return new PreAdvance();
    }
  }

  Future<RegisterAdvances> getMyAdvances(int userId) async {
    final SharedPreferences pref = await this.sPrefs;
    RegisterAdvances result = new RegisterAdvances();

    Uri url = appService<AppSettings>().envProd ? new Uri.https(this.apiUrl, '/api/Advances/GetByAccredited/$userId') : new Uri.http(this.apiUrl, '/api/Advances/GetByAccredited/$userId');

    final response = await http.get(url, headers: this.headers(pref));

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success'] as bool) {
        result = RegisterAdvances.fromJson(responseObject['data']);
      }
    }

    return result;
  }

  Future<DatesPeriod> getDatesPeriod() async {
    final SharedPreferences pref = await this.sPrefs;
    DatesPeriod result = DatesPeriod.fromJson({});

    Uri url = appService<AppSettings>().envProd ? new Uri.https(this.apiUrl, '/api/Accrediteds/GetCurrentPeriod') : new Uri.http(this.apiUrl, '/api/Accrediteds/GetCurrentPeriod');

    final response = await http.get(url, headers: this.headers(pref));

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);

      if (responseObject['success'] as bool) {
        result = DatesPeriod.fromJson(responseObject['data']);
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