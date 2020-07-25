class AuthResponse {
  bool success;
  String contract;
  String token;
  bool firstLogin;
  int type;
  String typeName;
  String urlNotice;

  AuthResponse({this.success, this.contract, this.token, this.firstLogin, this.urlNotice});
}