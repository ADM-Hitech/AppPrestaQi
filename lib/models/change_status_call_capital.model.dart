import 'dart:convert';
import 'dart:typed_data';

class ChangeStatusCallCapital {
  late String fileName;
  late Uint8List fileByte;
  late int capitaId;
  late int status;

  ChangeStatusCallCapital({
    this.fileName = '',
    Uint8List? fileByte,
    this.capitaId = 0,
    this.status = 0
  }) {
    if (fileByte != null) {
      this.fileByte = fileByte;
    }
  }

  String toJson() => json.encode({
    'file_name': fileName,
    'file_byte': fileByte,
    'capital_id': capitaId,
    'status': status
  });
}