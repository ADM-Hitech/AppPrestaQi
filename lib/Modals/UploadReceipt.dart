import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dashed_container/dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prestaQi/Models/ChangeStatusCallCapital.dart';
import 'package:prestaQi/Models/DataAdvanceCapitalNotification.dart';
import 'package:prestaQi/Services/InvestmentsService.dart';
import 'package:prestaQi/Services/SetupService.dart';

class UploadReceiptModal extends ModalRoute<void> {
  
  final DataAdvanceCapitalNotification info;

  UploadReceiptModal({this.info});

  @override
  Duration get transitionDuration => Duration(milliseconds: 100);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.4);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {

    return UploadReceipt(info: this.info);
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class UploadReceipt extends StatefulWidget {

  final DataAdvanceCapitalNotification info;
  UploadReceipt({this.info});
    
  @override
  UploadReceiptState createState() => UploadReceiptState();
}

class UploadReceiptState extends State<UploadReceipt> {

  DateTime date = DateTime.now();
  DateFormat dateFormat = new DateFormat('dd/MM/yyyy');
  DateFormat dateFormatVaucher = new DateFormat('ddMMyyyy');
  ImagePicker picker = new ImagePicker();
  File image;
  Completer completer = new Completer();
  double heightImage = 250;
  Uint8List bytesImages;
  ChangeStatusCallCapital changeStatus = new ChangeStatusCallCapital();
  String error = '';
  bool loading = false;
  bool uploadSuccess = false;
  Color border = Colors.grey;

  @override
  void initState() {
    super.initState();
    setState(() {
      this.changeStatus.capitaId = this.widget.info.capitalId;
      this.changeStatus.status = 2;
    });
  }

  void selectImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      final dirAplicationDocuments = await getApplicationDocumentsDirectory();

      setState(() {
        this.image = File(pickedFile.path);
        this.heightImage = 250;
        this.bytesImages = null;
        this.error = '';
      });

      var newImage = imageLib.decodeImage(this.image.readAsBytesSync());
      var newSize = this.getNewSize(newImage.width, newImage.height, 0, 700);

      var thumb = imageLib.copyResize(newImage, width: newSize[0], height: newSize[1]);
      var finalImage = new File('${dirAplicationDocuments.path}/tes_convert.jpeg')..writeAsBytesSync(imageLib.encodeJpg(thumb, quality: 100));
      
      setState(() {
        this.bytesImages = finalImage.readAsBytesSync();
        this.changeStatus.fileByte = this.bytesImages;
        this.changeStatus.fileName = 'voucher_${this.widget.info.capitalId}${this.dateFormatVaucher.format(this.date)}.jpeg';
      });

      var decodedImage = await decodeImageFromList(this.bytesImages);

      if (decodedImage.height > decodedImage.width) {
        setState(() {
          this.heightImage = 350;
        });
      }

    } on PlatformException {
      print('Error');
    } catch (e) {
      print(e);
    }
  }

  List<int> getNewSize(int width, int height, int porcent, int min) {

    int maxWidth = min;
    double ratio = 0;

    if (width > maxWidth) {
      ratio = maxWidth / width;
      height = (height * ratio).floor();
      width = (width * ratio).floor();
    }

    return [width, height];

    /*if (width > height) {
      var radio = height / width;
      int newWidth = (width - min) * (porcent / 100).floor();
      int newHigth = (((height - min) * radio) * (porcent / 100)).floor();
      return [newWidth, newHigth];
    } else {
      var radio = width / height;
      int newWidth = ((width - min * radio) * (porcent / 100)).floor();
      int newHigth = ((height - min) * (porcent / 100)).floor();
      return [newWidth, newHigth];
    }*/
  }

  void submit() {
    setState(() {
      this.loading = true;
      this.uploadSuccess = false;
      this.error = '';
      this.border = Colors.grey;
    });

    if (this.changeStatus.fileByte == null) {
      setState(() {
        this.loading = false;
        this.border = Colors.red;
      });

      return;
    }

    appService<InvestmentsService>().changeStatusCapital(this.changeStatus).then((value) {
      if (value) {
        setState(() {
          this.uploadSuccess = true;
          this.heightImage = 0;
        });

        Timer(Duration(seconds: 1, milliseconds: 500), () {
          Navigator.pop(context, true);
        });
      } else {
        print('else');
        setState(() {
          this.error = 'Error al subir el archivo';
          this.loading = false;
        });
      }
    }).catchError((onError) {
      print(onError);
      setState(() {
        this.error = 'Error al subir el archivo';
        this.loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width * .9,
          height: this.heightImage + 312,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                height: this.heightImage + 312,
                child: ListView.builder(
                  itemCount: 1,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (ctnx, i) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text('SUBIR COMPROBANTE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 102, 1),
                                fontSize: 23,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          if (this.uploadSuccess) ...[
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Image.asset('assets/icons/circle_success.png', width: 90, height: 90),
                              ),
                            )
                          ] else ...[
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(bottom: 25),
                              child: GestureDetector(
                                onTap: this.selectImage,
                                child: DashedContainer(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: this.heightImage,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0)
                                    ),
                                    child: this.image == null ?
                                      Align(
                                          child: Container(
                                            child: SvgPicture.asset(
                                              'assets/icons/ico-subir-archivo.svg',
                                              color: Color.fromRGBO(0, 0, 102, 1),
                                              width: 100,
                                            ),
                                        ),
                                      )
                                      :
                                      Center(
                                        child: Image.file(this.image),
                                      )
                                  ),
                                  dashColor: this.border,
                                  borderRadius: 10.0,
                                  dashedLength: 10.0,
                                  blankLength: 2.0,
                                  strokeWidth: 2.0,
                                ),
                              )
                            ),
                            if (this.error.isNotEmpty)
                              Container(
                                child: Text(this.error, style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12
                                )),
                              )
                            ,
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                child: GestureDetector(
                                  onTap: this.loading ? () {} : this.submit,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 102, 1),
                                      borderRadius: BorderRadius.circular(40)
                                    ),
                                    child: this.loading ?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'ENVIAR', 
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                          )
                                        ),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          margin: EdgeInsets.only(left: 15),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            backgroundColor: Color.fromRGBO(0, 0, 102, 1),
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        )
                                      ],
                                    ) :
                                    Center(
                                      child: Text(
                                        'ENVIAR',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(198, 200, 208, 1),
                                      borderRadius: BorderRadius.circular(40)
                                    ),
                                    child: Center(
                                      child: Text(
                                        'CANCELAR', 
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]
                        ],
                      ),
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
