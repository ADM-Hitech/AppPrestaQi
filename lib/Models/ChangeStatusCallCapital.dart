import 'dart:convert';
import 'dart:typed_data';

class ChangeStatusCallCapital {
  String fileName;
  Uint8List fileByte;
  int capitaId;
  int status;

  ChangeStatusCallCapital({this.fileName, this.fileByte, this.capitaId, this.status});

  String toJson() => json.encode({
    'file_name': fileName,
    'file_byte': fileByte,
    'capital_id': capitaId,
    'status': status
  });
}