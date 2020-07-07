import 'dart:convert';
import 'dart:io';

import 'package:prestaQi/Models/InvestmentModel.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InvestmentsService {

  String apiUrl;
  Future<SharedPreferences> sPref = SharedPreferences.getInstance();

  InvestmentsService() {
    this.apiUrl = appService<AppSettings>().apiUrl;
  }

  Future<List<InvestmentModel>> fetchInvestment() async {
    final SharedPreferences pref = await this.sPref;
    List<InvestmentModel> investments = new List<InvestmentModel>();

    final response = await http.post('${this.apiUrl}Capitals/GetMyInvestments', body: '{}', headers: this.headers(pref));
    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success'] as bool) {
        Iterable result = responseObject['data']['myInvestments'] as Iterable;

        investments = result.map((investment) => InvestmentModel.fromJson(investment)).toList();
      }
    }
    
    return investments;
  }

  Map<String, String> headers(SharedPreferences pref) {
    return {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString('token')}',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    };
  }
}