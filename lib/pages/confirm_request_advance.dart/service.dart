import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prestaqi/models/info_bank.model.dart';
import 'package:prestaqi/models/pre_advance.model.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/utils/app_settings.utils.dart';

class ConfirmRequestAdvanceService {
  late String apiUrl;
  late String completeApiUrl;
  late PreferenceUser pref;

  ConfirmRequestAdvanceService() {
    apiUrl = appService<AppSettings>().apiUrl;
    completeApiUrl = appService<AppSettings>().completeApiUrl();
    pref = PreferenceUser();
  }

  Future<PreAdvanceModel> calculateAdvanceWithAmount(double amount) async {

    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, '/api/Advances/CalculateAdvance') : Uri.http(apiUrl, '/api/Advances/CalculateAdvance');

    final response = await http.post(url, body: "{'amount': $amount}", headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    });

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success'] as bool) {
        PreAdvanceModel responseCalculate = PreAdvanceModel.fromJson(responseObject['data']); 

        return responseCalculate;
      }

      return PreAdvanceModel();
    } else {
      return PreAdvanceModel();
    }
  }

  Future<InfoBankModel> getInfoBanck() async {
    InfoBankModel result = InfoBankModel(
      clabe: '',
      institutionName: '',
      accountNumber: ''
    );

    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, '/api/Users/GetUser') : Uri.http(apiUrl, '/api/Users/GetUser');

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}',
    });

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success'] as bool) {
        result.accountNumber = responseObject['data']['user']['account_Number'] ?? '';
        result.clabe = responseObject['data']['user']['clabe'] ?? '';
        result.institutionName = responseObject['data']['user']['institution_Name'] ?? '';
        result.firstName = responseObject['data']['user']['first_Name'] ?? '';
        result.lastName = responseObject['data']['user']['last_Name'] ?? '';
        result.contractNumber = responseObject['data']['user']['contract_number'] ?? '';
        result.companyName = responseObject['data']['user']['company_Name'] ?? '';
      }
    }

    return result;
  }

  Future<bool> requestAdvance(double amount, double latitude, double longitude) async {

    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, '/api/Advances') : Uri.http(apiUrl, '/api/Advances');

    final response = await http.post(url, body: "{'amount': $amount, 'latitude': $latitude, 'longitude': $longitude}", headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success'] as bool) {
        return true;
      }
    }

    return false;
  }
}