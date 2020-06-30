class UserToken {
  String givenName;
  String email;
  String jti;
  int exp;
  String iss;
  String aud;

  UserToken({this.givenName, this.email, this.jti, this.exp, this.iss, this.aud});

  factory UserToken.fromJson(Map<String, dynamic> json) {
    if (json == null) return new UserToken();

    return UserToken(
      givenName: json['given_name'] ?? '',
      email: json['email'] ?? '',
      jti: json['jti'] ?? '',
      exp: int.tryParse((json['exp'] ?? 0).toString()),
      iss: json['iss'] ?? '',
      aud: json['aud'] ?? ''
    );
  }
}