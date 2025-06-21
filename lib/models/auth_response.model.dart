class AuthResponse {
  late bool success;
  late String contract;
  late String token;
  late bool firstLogin;
  late int type;
  late String typeName;
  late String urlNotice;

  AuthResponse({
    this.success = false,
    this.contract = '',
    this.token = '',
    this.firstLogin = true,
    this.urlNotice = ''
  });
}