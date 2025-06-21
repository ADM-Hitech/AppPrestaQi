import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:prestaqi/models/calculate_advance.model.dart';
import 'package:prestaqi/models/my_profile.model.dart';
import 'package:prestaqi/pages/request_advance/content.dart';
import 'package:prestaqi/pages/request_advance/service.dart';
import 'package:prestaqi/services/preference_user.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/utils/geolocation.dart';
import 'package:prestaqi/utils/hexcolor.dart';
import 'package:prestaqi/widgets/app_bar.widget.dart';
import 'package:prestaqi/widgets/drawer_menu.widget.dart';

import '../../services/navigation.service.dart';

class RequestAdvancePage extends StatefulWidget {
  const RequestAdvancePage({ super.key });

  @override
  RequestAdvanceState createState() => RequestAdvanceState();
}

class RequestAdvanceState extends State<RequestAdvancePage> {

  final TextEditingController valueControl = TextEditingController(text: '');
  double valueAdvance = 0;
  double maxValue = 1;
  Color colorAmount = HexColor.fromHex('#ff2626');
  bool loading = true;
  bool errorAmount = true;
  bool isBlocked = false;
  bool insufficientBalance = false;
  CalculateAdvance calculateAdvance = CalculateAdvance();
  RequestAdvanceService service = RequestAdvanceService();
  PreferenceUser pref = PreferenceUser();
  MyProfileModel user = MyProfileModel();
  bool isFixedPayments = false;
  String errorMessage = '';
  late Position geolocation;
  late StreamSubscription<ServiceStatus> locationStatusStream;

  @override
  void initState() {
    super.initState();
    valueControl.text = valueAdvance.toStringAsFixed(2);
    Future.microtask(() => fetchMaxAmount());
    Future.microtask(() => startListeningLocationStatus());
  }

  void startListeningLocationStatus() {
    locationStatusStream = Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      if (status == ServiceStatus.enabled) {
        fetchMaxAmount();
      } else {
        setState(() {
          errorMessage = appService<Geolocation>().message;
        });
      }
    });
  }

  Future<void> requestActiveLocation() async {
    final statusLocation = await Geolocator.isLocationServiceEnabled().catchError((onError) {

    });

    if (!statusLocation) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
      await Geolocator.openLocationSettings();
      return;
    }

    fetchMaxAmount();
  }

  void fetchMaxAmount() {
    setState(() {
      loading = true;
    });

    Future.wait([
      service.getMyProfile(),
      appService<Geolocation>().getGeolocation()
    ]).then((response) {
      MyProfileModel user = response.first as MyProfileModel;
      geolocation = response.last as Position;

      isFixedPayments = user.typeContract == 'fixedpayment';
      isBlocked = user.isBlocked;
      calculateAdvance.urlCartaMandato = user.urlCartaMandato;
      errorMessage = '';

      setState(() {});

      if (!isBlocked) {
        service.calculateAdvance().then((value) {
          insufficientBalance = value <= 0;
          maxValue = value <= 0 ? 1 : value;
          loading = false;

          setState(() {});
        }).catchError((onError) {
          loading = false;
          setState(() {});
        });
      } else {
        loading = false;
        setState(() {});
      }
    }).catchError((onError) {
      setState(() {
        loading = false;
        errorMessage = onError.toString().replaceAll('Exception:', '');
      });
    });
  }

  void requestAdvance() {
    setState(() {
      colorAmount = const Color.fromRGBO(77, 77, 77, 1);
    });

    if (errorAmount) {
      setState(() {
        colorAmount = HexColor.fromHex('#ff2626');
      });
    } else {

      calculateAdvance.amount = valueAdvance;
      calculateAdvance.maximumAmount = maxValue;
      calculateAdvance.longitude = geolocation.longitude;
      calculateAdvance.latitude = geolocation.latitude;

      appService<NavigationService>().navigateTo('confirm-request-advance', arguments: calculateAdvance);
    }
  }

  void updateValueAdvance(double value) {
    setState(() {
      valueAdvance = value.floorToDouble();
      
      if (isFixedPayments && [3000, 5000, 10000].any((element) => element == valueAdvance)) {
        colorAmount = const Color.fromRGBO(77, 77, 77, 1);
        errorAmount = false;
      } else if (valueAdvance > 0 && !isFixedPayments) {
        colorAmount = const Color.fromRGBO(77, 77, 77, 1);
        errorAmount = false;
      } else {
        colorAmount = HexColor.fromHex('#ff2626');
        errorAmount = true;
      }

      valueControl.text = NumberFormat.currency(symbol: '').format(valueAdvance);
    });
  }

  void updateValueWithInput(String value) {
    var newValue = double.tryParse(value);

    if (newValue != null) {
      setState(() {
        if (newValue <= 0 || newValue > maxValue) {
          colorAmount = HexColor.fromHex('#ff2626');
          errorAmount = true;
        } else {
          colorAmount = const Color.fromRGBO(77, 77, 77, 1);
          errorAmount = false;
        }
      });
    }

    if (newValue != null && newValue <= maxValue ) {
      setState(() {
        valueAdvance = newValue;
      });
    }
  }

  double getSizeTitle(double height) {
    if (height > 667) {
      return 50;
    } else {
      return 40;
    }
  }

  double getHightTitle(double height) {
    if (height > 667) {
      return 320;
    } else {
      return 280;
    }
  }

  double getTopBody(double height) {
    if (height > 667) {
      return 250;
    } else {
      return 200;
    }
  }

  double getSpacesBetween(double height) {
    if (height > 667) {
      return 15;
    } else {
      return 20;
    }
  }

  double getSpacesBetweenButton(double height) {
    if (height > 667) {
      return 80;
    } else {
      return 30;
    }
  }

  double getSpacesBetweenSlide(double height) {
    if (height > 667) {
      return 70;
    } else {
      return 25;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(context: context),
      drawer: const DrawerMenu(),
      body: requestAdvanceBody(state: this)
    );
  }
}