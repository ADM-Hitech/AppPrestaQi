import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prestaqi/models/my_profile.model.dart';
import 'package:prestaqi/pages/profile/content.dart';
import 'package:prestaqi/pages/profile/service.dart';
import 'package:prestaqi/widgets/app_bar.widget.dart';
import 'package:prestaqi/widgets/drawer_menu.widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfilePage> {

  MyProfileModel user = MyProfileModel(
    firstName: '-',
    lastName: '- -',
    id: 0,
    accountNumber: '-',
    advances: '',
    age: 0,
    institutionId: 0,
    institutionName: '',
    mail: '',
    netMonthlySalary: 0,
    companyName: '',
    position: '',
    clabe: '',
    type: 0,
    periodName: '',
    periodId: 0
  );
  bool loading = true;
  NumberFormat numberFormat = NumberFormat("#,###.0#", "en_US");
  ProfileService service = ProfileService();

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  String letterName() {
    var fullName = '${user.firstName} ${user.lastName}';
    var split = fullName.split(' ');
    String letters = (split[0][0]) + (split[1][0]);

    return letters;
  }

  void fetchProfile() {
    service.getMyProfile().then((value) {
      setState(() {
        user = value;
        loading = false;
      });
    }).catchError((onError) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(context: context),
      drawer: const DrawerMenu(),
      body: profileBody(state: this),
    );
  }
}