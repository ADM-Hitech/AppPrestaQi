import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:prestaQi/Models/InfoBank.dart';
import 'package:prestaQi/Models/MyProfile.dart';
import 'package:prestaQi/Models/UserToken.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserService {
  
  String apiUrl;
  UserToken userToken;
  Future<SharedPreferences> sPrefs = SharedPreferences.getInstance();

  UserService() {
    this.apiUrl = appService<AppSettings>().apiUrl;
  }

  Future<InfoBank> getInfoBanck() async {
    
    SharedPreferences pref = await this.sPrefs;
    InfoBank result = InfoBank(
      clabe: '',
      institutionName: '',
      accountNumber: ''
    );

    Uri url = kReleaseMode ? new Uri.https(this.apiUrl, '/api/Users/GetUser') : new Uri.http(this.apiUrl, '/api/Users/GetUser');

    final response = await http.get(url, headers: this.headers(pref));

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

  Future<MyProfileModel> getMyProfile() async {

    SharedPreferences pref = await this.sPrefs;
    MyProfileModel user = new MyProfileModel();
    Uri url = kReleaseMode ? new Uri.https(this.apiUrl, '/api/Users/GetUser') : new Uri.http(this.apiUrl, '/api/Users/GetUser');
    
    final response = await http.get(url, headers: this.headers(pref));

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);

      if (responseObject['success'] as bool) {
        user = new MyProfileModel.fromJson(responseObject['data']['user']);
        user.type = responseObject['data']['type'];
        user.typeName = responseObject['data']['typeName'];
        user.urlCartaMandato = 'https://${this.apiUrl}/api/Users/GetCartaMandato?token=${pref.getString('token')}';
      }
    }

    return user;
  }

  Future<bool> deleteMyAccount(int userId, int type) async {

    SharedPreferences pref = await this.sPrefs;
    Uri url = kReleaseMode ? new Uri.https(this.apiUrl, '/api/Administrative/DeleteAccount') : new Uri.http(this.apiUrl, '/api/Administrative/DeleteAccount');

    final response = await http.put(url, body: "{'UserId': $userId, 'Type': $type}", headers: this.headers(pref));

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);

      return (responseObject['success'] as bool);
    }

    return false;
  }

  Map<String, String> headers(SharedPreferences pref) {
    return {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString('token')}',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    };
  }
}