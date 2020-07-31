import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prestaQi/Models/UserToken.dart';
import 'package:prestaQi/Screens/SettingInfoAccount/setting_info_account_content.dart';
import 'package:prestaQi/Services/AuthService.dart';
import 'package:prestaQi/Services/SetupService.dart';
import 'package:prestaQi/Utils/ScreenResponsive.dart';
import 'package:http/http.dart' as http;

class SettingInfoAccount extends StatefulWidget {

  @override
  SettingInfoAccountState createState() => SettingInfoAccountState();
}

class SettingInfoAccountState extends State<SettingInfoAccount> {
  
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenResponsive screen;
  bool loading = false;
  int porcen = 0;
  UserToken user;
  List<List<int>> chunks = new List();

  @override
  void initState() {
    super.initState();
    this.screen = new ScreenResponsive(context);
    this.getUser();
  }

  void getUser() {
    appService<AuthService>().me().then((value) {
      setState(() {
        this.user = value;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  void downloadMyInfo() async {
    Dio dio = Dio();

    try  {
      var url = this.user.uriApi;

      if (this.user.type == 3) {
        url = url + "Advances/ExportMyAdvances/${this.user.userId}";
      } else {
        url = url + "Investors/GetMyInvestments/${this.user.userId}";
      }

      var dirDown = await DownloadsPathProvider.downloadsDirectory;

      var permissionStatus = await Permission.storage.request().isGranted;
      if (permissionStatus) {
        setState(() {
          this.loading = true;
          this.porcen = 0;
        });

        await dio.download(
          url,
          "${dirDown.path}/miInformación.xlsx", 
          onReceiveProgress: (rec, total) {
          
          setState(() {
            this.porcen = ((rec / total) * 100).floor();
          });
        }, options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${this.user.token}'
        }));

        var byteDataFile = new File("${dirDown.path}/miInformación.xlsx").readAsBytesSync();
        await Share.file('mi información', 'miInformación.xlsx', byteDataFile, 'application/vnd.ms-excel');

        setState(() {
          this.loading = false;
        });
      }
      
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 244, 255, 1),
      key: this.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 244, 255, 1),
        elevation: 0.0,
        centerTitle: true,
        leading: Align(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: SvgPicture.asset(
                'assets/icons/ico-flecha-izquierda.svg',
                color: Color.fromRGBO(143, 146, 163, 1),
                width: 20,
              ),
            ),
          ),
        ),
        title: Container(
          child: Text(
            'Informe de mi cuenta',
            style: TextStyle(
              color: Color.fromRGBO(143, 146, 163, 1),
              fontWeight: FontWeight.w600
            )
          ),
        ),
      ),
      body: SettingInfoAccountContent(state: this),
    );
  }
}