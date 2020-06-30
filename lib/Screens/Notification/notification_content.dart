import 'package:flutter/material.dart';
import 'package:prestaQi/Screens/Notification/notification.dart';
import 'package:prestaQi/Utils/HexColor.dart';

class NotificationContent extends StatelessWidget {

  final NotificationState state;

  NotificationContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {
    
    return new Container(
      height: this.state.screen.height,
      width: this.state.screen.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60)
        )
      ),
      child: ListView.builder(
        padding: EdgeInsets.only(top: 35, left: 0, right: 0, bottom: 0),
        physics: BouncingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (cntx, i) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color.fromRGBO(222, 227, 237, 1))
                  )
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor.fromHex('#2865ff'),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      margin: EdgeInsets.only(right: 20),
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              'Tu dinero ha sudo depositado',
                              style: TextStyle(
                                color: Color.fromRGBO(77, 77, 77, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Revisa tu cuenta bancaria',
                              style: TextStyle(
                                color: Color.fromRGBO(142, 145, 162, 1),
                                fontSize: 15
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color.fromRGBO(222, 227, 237, 1))
                  )
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor.fromHex('32379E'),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      margin: EdgeInsets.only(right: 20),
                      child: Icon(Icons.add_alert, color: Colors.white),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              'Tu contraseña se guardó con éxito',
                              style: TextStyle(
                                color: Color.fromRGBO(77, 77, 77, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Hace 28 días',
                              style: TextStyle(
                                color: Color.fromRGBO(142, 145, 162, 1),
                                fontSize: 15
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color.fromRGBO(222, 227, 237, 1))
                  )
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor.fromHex('32379E'),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      margin: EdgeInsets.only(right: 20),
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              'Bienvenido a PrestaQi',
                              style: TextStyle(
                                color: Color.fromRGBO(77, 77, 77, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Hace 30 días',
                              style: TextStyle(
                                color: Color.fromRGBO(142, 145, 162, 1),
                                fontSize: 15
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}