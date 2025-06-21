import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prestaqi/models/user_token.model.dart';
import 'package:prestaqi/pages/settings_info_account/content.dart';
import 'package:prestaqi/services/app.service.dart';
import 'package:prestaqi/services/setup.service.dart';
import 'package:prestaqi/widgets/app_bar.widget.dart';
import 'package:share_plus/share_plus.dart';

class SettingInfoAccountPage extends StatefulWidget {
  const SettingInfoAccountPage({super.key});

  @override
  SettingInfoAccountState createState() => SettingInfoAccountState();
}

class SettingInfoAccountState extends State<SettingInfoAccountPage> {

  bool loading = false;
  int porcen = 0;
  late UserTokenModel user;
  List<List<int>> chunks = [];

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() {
    appService<AppService>().me().then((value) {
      setState(() {
        user = value;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  void downloadMyInfo() async {
    Dio dio = Dio();

    try  {
      var url = user.uriApi;

      if (user.type == 3) {
        url = "$url/Advances/ExportMyAdvances/${user.userId}";
      } else {
        url = "$url/capitals/ExportMyInvestment?type=1"; //"Investors/GetMyInvestments/${this.user.userId}";
      }

      var dirDown;

      if (Platform.isIOS) {
        dirDown = await getApplicationDocumentsDirectory();
      } else {
        dirDown = await getDownloadsDirectory();
      }

      setState(() {
        loading = true;
        porcen = 0;
      });

      await dio.download(
        url,
        "${dirDown.path}/miInformación.xlsx", 
        onReceiveProgress: (rec, total) {
        
        setState(() {
          porcen = ((rec / total) * 100).floor();
        });
      }, options: Options(headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${user.token}'
      }));

      await SharePlus.instance.share(ShareParams(
        text: "miInformación.xlsx",
        files: [XFile("${dirDown.path}/miInformación.xlsx")]
      ));

      setState(() {
        loading = false;
      });
      
    } catch(e) {
      setState(() {
        loading = false;
      });
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 244, 255, 1),
      appBar: appBar(context: context, title: 'Informe de mi cuenta'),
      body: settingInfoAccountBody(state: this),
    );
  }
}