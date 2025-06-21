import 'package:geolocator/geolocator.dart';

class Geolocation {
  final String message = 'Te recordamos que, por disposición oficial, necesitamos que concedas el permiso de ubicación para poder utilizar la aplicación.';

  Future<Position> getGeolocation() async {
    bool checkUbicationIsActive;
    LocationPermission permission;

    checkUbicationIsActive = await Geolocator.isLocationServiceEnabled().catchError((onError) {
      throw Exception(message);
    });

    if (!checkUbicationIsActive) {
      throw Exception(message);
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();

      if (permission != LocationPermission.always && permission != LocationPermission.whileInUse) {
        throw Exception(message);
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}