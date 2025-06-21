import 'dart:convert';

import 'package:prestaqi/utils/custom_error.utils.dart';

class DecodeJwtService {
  static Map<String, dynamic>? parseJwt(String token) {
    if (token.isEmpty) return null;

    final parts = token.split('.');
    if (parts.length != 3) {
      throw const CustomErrorUtilsException('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw const CustomErrorUtilsException('invalid payload');
    }

    return payloadMap;
  }

  static bool validToken(String token) {
    if (token.isEmpty) {
      return false;
    }

    try {
      var result = parseJwt(token);
      if (result is Map<String, dynamic>) {
        var time = DateTime.now();
        if (result['exp'] < (time.millisecondsSinceEpoch / 1000)) {
          return false;
        }

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

   static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw const CustomErrorUtilsException('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
