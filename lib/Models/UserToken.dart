class UserToken {
  String givenName;
  String email;
  int type;
  String typeName;
  int userId;
  String jti;
  int exp;
  String iss;
  String aud;
  String urlGeneralNotice;
  String urlContratoMutuoAccredited;
  String urlCartaAvisoGeneral;
  String urlTransferDataPersonal;
  String uriApi;
  String token;

  UserToken({
    this.givenName,
    this.email,
    this.type,
    this.typeName,
    this.userId,
    this.jti,
    this.exp,
    this.iss,
    this.aud,
    this.urlGeneralNotice,
    this.urlContratoMutuoAccredited,
    this.urlCartaAvisoGeneral,
    this.urlTransferDataPersonal,
    this.uriApi,
    this.token
  });

  factory UserToken.fromJson(Map<String, dynamic> json) {
    if (json == null) return new UserToken();

    return UserToken(
      givenName: json['given_name'] ?? '',
      email: json['email'] ?? '',
      type: int.tryParse(json['Type'] ?? '0'),
      typeName: json['TypeName'] ?? '',
      userId: int.tryParse(json['UserId'] ?? '0'),
      jti: json['jti'] ?? '',
      exp: int.tryParse((json['exp'] ?? 0).toString()),
      iss: json['iss'] ?? '',
      aud: json['aud'] ?? ''
    );
  }
}