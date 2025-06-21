class UserTokenModel {
  late String givenName;
  late String email;
  late int type;
  late String typeName;
  late int userId;
  late String jti;
  late int exp;
  late String iss;
  late String aud;
  late String urlGeneralNotice;
  late String urlContratoMutuoAccredited;
  late String urlCartaAvisoGeneral;
  late String urlTransferDataPersonal;
  late String urlTerminosCondiciones;
  late String urlAvisoPrivacidad;
  late String uriApi;
  late String token;

  UserTokenModel({
    this.givenName = '',
    this.email = '',
    this.type = 0,
    this.typeName = '',
    this.userId = 0,
    this.jti = '',
    this.exp = 0,
    this.iss = '',
    this.aud = '',
    this.urlGeneralNotice = '',
    this.urlContratoMutuoAccredited = '',
    this.urlCartaAvisoGeneral = '',
    this.urlTransferDataPersonal = '',
    this.uriApi = '',
    this.token = ''
  });

  factory UserTokenModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return UserTokenModel();

    return UserTokenModel(
      givenName: json['given_name'] ?? '',
      email: json['email'] ?? '',
      type: int.tryParse(json['Type'] ?? '0') ?? 0,
      typeName: json['TypeName'] ?? '',
      userId: int.tryParse(json['UserId'] ?? '0') ?? 0,
      jti: json['jti'] ?? '',
      exp: int.tryParse((json['exp'] ?? 0).toString()) ?? 0,
      iss: json['iss'] ?? '',
      aud: json['aud'] ?? ''
    );
  }
}