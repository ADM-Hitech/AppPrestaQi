import 'dart:async';

class ValideForms {

  final validEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {

      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp  = RegExp(pattern);

      if (regExp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError('Email no es valido');
      }
    }
  );

  final validEmailOptiona = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {

      if (email == '') {
        sink.add(email);
      } else if (email != '') {
        String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp  = RegExp(pattern);

        if (regExp.hasMatch(email)) {
          sink.add(email);
        } else {
          sink.addError('Email no es valido');
        }
      }
    }
  );

  final validPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {

      if (password.isNotEmpty) {
        sink.add( password );
      } else {
        sink.addError('Ingrese una contraseña');
      }
    }
  );

  final validateEmpty = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (value.isNotEmpty) {
        sink.add(value);
      } else {
        sink.addError('El campo es requerido');
      }
    }
  );

  final validateEmptyTelephone = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (value.isNotEmpty && value.length == 10) {
        sink.add(value);
      } else {
        sink.addError('El campo es requerido');
      }
    }
  );

  final validateZipCode = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      String pattern = r'^[0-9]*$';
      RegExp regExp = RegExp(pattern);
      int? tryvalue = int.tryParse(value);

      if (value.isNotEmpty && value.length <= 5 && tryvalue != null && regExp.hasMatch(value)) {
        sink.add(value);
      } else {
        sink.addError('C.P no valido');
      }
    }
  );

  final validateTelephone = StreamTransformer<int, int>.fromHandlers(
    handleData: (value, sink) {
      if (value.toString().length == 10) {
        sink.add(value);
      } else {
        sink.addError('Numero de telefono no valido');
      }
    }
  );

  final validDayPayment = StreamTransformer<int, int>.fromHandlers(
    handleData: (value, sink) {
      if (value > 0 && value <= 31) {
        sink.add(value);
      } else {
        sink.addError('Día no valido');
      }
    }
  );

  final validateDate = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (DateTime.tryParse(value) != null) {
        sink.add(value);
      } else {
        sink.addError('El campo es requerido');
      }
    }
  );

  final validTermAndConditions = StreamTransformer<bool, bool>.fromHandlers(
    handleData: (value, sink) {
      if (value) {
        sink.add(value);
      } else {
        sink.addError('Es necesario aceptar el aviso de privacidad');
      }
    }
  );

  final validNumberNotZero = StreamTransformer<int, int>.fromHandlers(
    handleData: (value, snik) {
      if (value > 0) {
        snik.add(value);
      } else {
        snik.addError('El valor no es valido');
      }
    }
  );

  final validDoubleNotZero = StreamTransformer<double, double>.fromHandlers(
    handleData: (value, snik) {
      if (value > 0) {
        snik.add(value);
      } else {
        snik.addError('El valor no es valido');
      }
    }
  );

  final validClabeInterbancaria = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      String pattern = r'^[0-9]*$';
      RegExp regExp = RegExp(pattern);

      if (value.isNotEmpty && regExp.hasMatch(value) && value.length == 18) {
        sink.add(value);
      } else {
        sink.addError('Clabe no valida, min 18 dig');
      }
    }
  );

  final validAccountNumber = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      String pattern = r'^[0-9]*$';
      RegExp regExp = RegExp(pattern);

      if (value.isNotEmpty && regExp.hasMatch(value) && value.length >= 10) {
        sink.add(value);
      } else {
        sink.addError('Cuenta no valida, min 10 dig');
      }
    }
  );

  final validOnlyNumberWithDecimal = StreamTransformer<double, double>.fromHandlers(
    handleData: (value, sink) {
      String valueToString = value.toString();
      String pattern = r'^(\d)*(\.)?(\d+$)';
      RegExp regExp = RegExp(pattern);

      if (regExp.hasMatch(valueToString)) {
        sink.add(value);
      } else {
        sink.addError('El valor no es valido');
      }
    }
  );
}