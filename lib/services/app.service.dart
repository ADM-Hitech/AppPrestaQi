import 'dart:convert';
import 'dart:io';

import 'package:prestaqi/models/auth_response.model.dart';
import 'package:prestaqi/models/change_status_call_capital.model.dart';
import 'package:prestaqi/models/info_bank.model.dart';
import 'package:prestaqi/models/my_profile.model.dart';
import 'package:prestaqi/models/user_token.model.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:http/http.dart' as http;

import '../utils/app_settings.utils.dart';
import 'decode_jwt.service.dart';

class AppService {
  late String apiUrl;
  late String completeApiUrl;
  late PreferenceUser pref;

  AppService() {
    apiUrl = appService<AppSettings>().apiUrl;
    completeApiUrl = appService<AppSettings>().completeApiUrl();
    pref = PreferenceUser();
  }

  Future<UserTokenModel> me() async {
    var jwtObject = DecodeJwtService.parseJwt(pref.token);
    UserTokenModel userToken = UserTokenModel.fromJson(jwtObject!);
    userToken.urlGeneralNotice = '${appService<AppSettings>().envProd ? 'https://' : 'http://'}$apiUrl/api/Users/GetContract?token=${pref.token}';
    
    userToken.urlContratoMutuoAccredited = '${appService<AppSettings>().envProd ? 'https://' : 'http://'}$apiUrl/api/Users/GetContratoMutuo?token=${pref.token}';
    userToken.urlCartaAvisoGeneral = '${appService<AppSettings>().envProd ? 'https://' : 'http://'}$apiUrl/api/Users/GetCartaAvisoGeneral?token=${pref.token}';
    userToken.urlTransferDataPersonal = '${appService<AppSettings>().envProd ? 'https://' : 'http://'}$apiUrl/api/Users/GetTransferenciaDatosPersonales?token=${pref.token}';
    userToken.urlAvisoPrivacidad = '${appService<AppSettings>().envProd ? 'https://' : 'http://'}$apiUrl/api/Users/GetAvisoPrivacidad?token=${pref.token}';
    userToken.urlTerminosCondiciones = '${appService<AppSettings>().envProd ? 'https://' : 'http://'}$apiUrl/api/Users/GetTerminosCondiciones?token=${pref.token}';
    userToken.uriApi = completeApiUrl;
    userToken.token = pref.token;

    return userToken;
  }

  bool logout() {
    pref.logout();

    return true;
  }

  Future<MyProfileModel> getMyProfile() async {
    String path = 'api/Users/GetUser';
    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, path) : Uri.http(apiUrl, path);

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}'
    });

    MyProfileModel user = MyProfileModel();

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);

      if (responseObject['success']) {
        user = MyProfileModel.fromJson(responseObject['data']['user']);
        user.type = responseObject['data']['type'];
        user.typeName = responseObject['data']['typeName'];
        user.urlCartaMandato = '$completeApiUrl/Users/GetCartaMandato?token=${pref.token}';
      }
    }

    return user;
  }

  Future<bool> changeStatusCapital(ChangeStatusCallCapital newStatus) async {
    String path = 'api/Capitals/ChangeStatus';
    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, path) : Uri.http(apiUrl, path);

    final response = await http.post(url, body: newStatus.toJson(), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}'
    });

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success'] as bool) {
        return true;
      }
    }

    return false;
  }

  Future<bool> isFirstLogin() async  {
    pref.isLogind = false;

    return true;
  }

  Future<AuthResponse> changePassword(String password, bool rememberUser) async {
    AuthResponse authResponse = AuthResponse();
    authResponse.success = false;

    Uri url = appService<AppSettings>().envProd ? Uri.https(apiUrl, '/api/Administrative/ChangePassword') : Uri.http(apiUrl, '/api/Administrative/ChangePassword');

    final response = await http.put(url, body: '{"password": "$password"}', headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${pref.token}'
    });

    if (response.statusCode == 200) {
      var responseObject = json.decode(response.body);
      if (responseObject['success']) {
        authResponse.type = pref.type;
        authResponse.typeName = pref.typeName;
        authResponse.urlNotice = '$completeApiUrl/Users/GetContract?token=${pref.token}';
        authResponse.success = true;
        pref.isLogind = true;
        if (rememberUser) {
          pref.rPass = password;
        }
      }
    }

    return authResponse;
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
}