import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image/image.dart' as image_lib;
import 'package:another_dashed_container/another_dashed_container.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prestaqi/models/change_status_call_capital.model.dart';
import 'package:prestaqi/models/data_advance_capital_notification.model.dart';
import 'package:prestaqi/services/app.service.dart';
import 'package:prestaqi/services/setup.service.dart';

class UploadReceiptModal extends ModalRoute<void> {
  
  final DataAdvanceCapitalNotificationModel info;

  UploadReceiptModal({required this.info});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withValues(alpha: 0.4);

  @override
  String? get barrierLabel => null;

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

    return UploadReceipt(info: info);
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

  final DataAdvanceCapitalNotificationModel info;
  const UploadReceipt({super.key,  required this.info});
    
  @override
  UploadReceiptState createState() => UploadReceiptState();
}

class UploadReceiptState extends State<UploadReceipt> {

  DateTime date = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateFormat dateFormatVaucher = DateFormat('ddMMyyyy');
  ImagePicker picker = ImagePicker();
  late File image;
  Completer completer = Completer();
  double heightImage = 250;
  Uint8List? bytesImages;
  ChangeStatusCallCapital changeStatus = ChangeStatusCallCapital();
  String error = '';
  bool loading = false;
  bool uploadSuccess = false;
  Color border = Colors.grey;

  @override
  void initState() {
    super.initState();
    setState(() {
      changeStatus.capitaId = widget.info.capitalId;
      changeStatus.status = 2;
    });
  }

  void selectImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      final dirAplicationDocuments = await getApplicationDocumentsDirectory();

      setState(() {
        image = File(pickedFile!.path);
        heightImage = 250;
        bytesImages = null;
        error = '';
      });

      var newImage = image_lib.decodeImage(image.readAsBytesSync());
      var newSize = getNewSize(newImage!.width, newImage.height, 0, 700);

      var thumb = image_lib.copyResize(newImage, width: newSize[0], height: newSize[1]);
      var finalImage = File('${dirAplicationDocuments.path}/tes_convert.jpeg')..writeAsBytesSync(image_lib.encodeJpg(thumb, quality: 100));
      
      setState(() {
        bytesImages = finalImage.readAsBytesSync();
        changeStatus.fileByte = bytesImages!;
        changeStatus.fileName = 'voucher_${widget.info.capitalId}${dateFormatVaucher.format(date)}.jpeg';
      });

      var decodedImage = await decodeImageFromList(bytesImages!);

      if (decodedImage.height > decodedImage.width) {
        setState(() {
          heightImage = 350;
        });
      }

    } on PlatformException {
      setState(() {
        error = "Error al seleccionar el archivo";
      });
    } catch (e) {
      setState(() {
        error = "Error al seleccionar el archivo";
      });
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
  }

  void submit() {
    setState(() {
      loading = true;
      uploadSuccess = false;
      error = '';
      border = Colors.grey;
    });

    appService<AppService>().changeStatusCapital(changeStatus).then((value) {
      if (value) {
        setState(() {
          uploadSuccess = true;
          heightImage = 0;
        });

        Timer(const Duration(seconds: 1, milliseconds: 500), () {
          Navigator.pop(context, true);
        });
      } else {
        setState(() {
          error = 'Error al subir el archivo';
          loading = false;
        });
      }
    }).catchError((onError) {
      setState(() {
        error = 'Error al subir el archivo';
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width * .9,
        height: heightImage + 312,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              height: heightImage + 312,
              child: ListView.builder(
                itemCount: 1,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctnx, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const Text('SUBIR COMPROBANTE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 102, 1),
                              fontSize: 23,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Text('(OPCIONAL)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 102, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        if (uploadSuccess) ...[
                          Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: Center(
                              child: Image.asset('assets/icons/circle_success.png', width: 90, height: 90),
                            ),
                          )
                        ] else ...[
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(bottom: 25),
                            child: GestureDetector(
                              onTap: selectImage,
                              child: DashedContainer(
                                dashColor: border,
                                borderRadius: 10.0,
                                dashedLength: 10.0,
                                blankLength: 2.0,
                                strokeWidth: 2.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: heightImage,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: image == null ?
                                    Align(
                                        child: SvgPicture.asset(
                                          'assets/icons/ico-subir-archivo.svg',
                                          colorFilter: ColorFilter.mode(const Color.fromRGBO(0, 0, 102, 1), BlendMode.srcIn),

                                          width: 100,
                                        ),
                                    )
                                    :
                                    Center(
                                      child: Image.file(image),
                                    )
                                ),
                              ),
                            )
                          ),
                          if (error.isNotEmpty)
                            Text(error, style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12
                            ))
                          ,
                          const SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: loading ? () {} : submit,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 0, 102, 1),
                                  borderRadius: BorderRadius.circular(40)
                                ),
                                child: loading ?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
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
                                      margin: const EdgeInsets.only(left: 15),
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        backgroundColor: Color.fromRGBO(0, 0, 102, 1),
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  ],
                                ) :
                                const Center(
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
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, false);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(198, 200, 208, 1),
                                    borderRadius: BorderRadius.circular(40)
                                  ),
                                  child: const Center(
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
    );
  }
}
