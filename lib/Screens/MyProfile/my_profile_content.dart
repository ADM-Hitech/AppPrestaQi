import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prestaQi/Screens/MyProfile/my_profile.dart';
import 'package:prestaQi/Utils/HexColor.dart';

class MyProfileContent extends StatelessWidget {
  
  final MyProfileState state;

  MyProfileContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {
    
    return new Container(
      height: this.state.screen.height,
      width: this.state.screen.width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: 290,
              width: this.state.screen.width,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#1292ff'),
                image: DecorationImage(
                  image: AssetImage('assets/images/background_header.png'),
                  fit: BoxFit.none,
                  alignment: Alignment.bottomCenter
                )
              )
            ),
          ),
          Positioned(
            top: 95.0,
            child: Container(
              width: this.state.screen.width,
              height: this.state.screen.height,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#eff4ff'),
                borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 102, .4),
                    spreadRadius: 5,
                    blurRadius: 50,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              child: this.state.loading ?
                Center(
                  child: CircularProgressIndicator(),
                )
              :
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      width: this.state.screen.width,
                      height: 150,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            margin: EdgeInsets.only(right: 25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              gradient: new LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  HexColor.fromHex('#3333ff'),
                                  HexColor.fromHex('#33ccff'),
                                ]
                              )
                            ),
                            child: Center(
                              child: Text(
                                this.state.letterName(),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white
                                )
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: this.state.screen.width - 175,
                                  child: Text(
                                    '${this.state.user.firstName} ${this.state.user.lastName}', 
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  child: Text(
                                    'ID ${this.state.user.id.toString().padLeft(6, '0')}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: HexColor.fromHex('#000066'),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(65)
                        )
                      )
                    ),
                    Container(
                      width: this.state.screen.width,
                      height: this.state.screen.height - 255,
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        physics: BouncingScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (cntx, i) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 25),
                                width: this.state.screen.width * .8,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: SvgPicture.asset(
                                        'assets/icons/ico-perfil-user.svg',
                                        color: Color.fromRGBO(40, 101, 255, 1),
                                        width: 22,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        'DATOS PERSONALES',
                                        style: TextStyle(
                                          color: Color.fromRGBO(77, 77, 77, 1),
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: this.state.screen.width * .9,
                                margin: EdgeInsets.only(top: 15),
                                height: 90,
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 4),
                                      padding: EdgeInsets.only(left: 25),
                                      width: this.state.screen.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(13),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(77, 77, 77, .2),
                                            spreadRadius: 0,
                                            blurRadius: 10,
                                            offset: Offset(0, 0)
                                          )
                                        ]
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Text(
                                              '${this.state.user.firstName} ${this.state.user.lastName}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(77, 77, 77, 1)
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            child: Text(
                                              this.state.user.mail,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(77, 77, 77, 1)
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 15,
                                      height: 60,
                                      child: Container(
                                        width: 8,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(202, 206, 230, 1),
                                          borderRadius: BorderRadius.circular(4)
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (this.state.user.type == 3)
                                Container(
                                  padding: EdgeInsets.only(top: 25),
                                  width: this.state.screen.width * .8,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: SvgPicture.asset(
                                          'assets/icons/ico-perfil-tarjeta.svg',
                                          color: Color.fromRGBO(40, 101, 255, 1),
                                          width: 22,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'DATOS DE NÓMINA',
                                          style: TextStyle(
                                            color: Color.fromRGBO(77, 77, 77, 1),
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ,
                              if (this.state.user.type == 3)
                                Container(
                                  width: this.state.screen.width * .9,
                                  margin: EdgeInsets.only(top: 15),
                                  height: 110,
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 4),
                                        padding: EdgeInsets.only(left: 25, right: 25),
                                        width: this.state.screen.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(13),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromRGBO(77, 77, 77, .2),
                                              spreadRadius: 0,
                                              blurRadius: 10,
                                              offset: Offset(0, 0)
                                            )
                                          ]
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                this.state.user.companyName,
                                                style: TextStyle(
                                                  fontSize: 16.5,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(77, 77, 77, 1)
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Esquema de pago',
                                                    style: TextStyle(
                                                      fontSize: 16.5,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color.fromRGBO(77, 77, 77, 1)
                                                    ),
                                                  ),
                                                  Text(
                                                    this.state.user.periodName,
                                                    style: TextStyle(
                                                      fontSize: 16.5,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromRGBO(77, 77, 77, 1)
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Sueldo mensual neto',
                                                    style: TextStyle(
                                                      fontSize: 16.5,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color.fromRGBO(77, 77, 77, 1)
                                                    ),
                                                  ),
                                                  Text(
                                                    '\$${this.state.numberFormat.format(this.state.user.netMonthlySalary)}',
                                                    style: TextStyle(
                                                      fontSize: 16.5,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromRGBO(77, 77, 77, 1)
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 15,
                                        height: 80,
                                        child: Container(
                                          width: 8,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(202, 206, 230, 1),
                                            borderRadius: BorderRadius.circular(4)
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ,
                              Container(
                                padding: EdgeInsets.only(top: 25),
                                width: this.state.screen.width * .8,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 15),
                                      child: SvgPicture.asset(
                                        'assets/icons/ico-perfil-datos.svg',
                                        color: Color.fromRGBO(40, 101, 255, 1),
                                        width: 22,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        'DATOS BANCARIOS',
                                        style: TextStyle(
                                          color: Color.fromRGBO(77, 77, 77, 1),
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: this.state.screen.width * .9,
                                margin: EdgeInsets.only(top: 15),
                                height: 110,
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 4),
                                      padding: EdgeInsets.only(left: 25, right: 25),
                                      width: this.state.screen.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(13),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(77, 77, 77, .2),
                                            spreadRadius: 0,
                                            blurRadius: 10,
                                            offset: Offset(0, 0)
                                          )
                                        ]
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Banco',
                                                  style: TextStyle(
                                                    fontSize: 16.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(77, 77, 77, 1)
                                                  ),
                                                ),
                                                Text(
                                                  this.state.user.institutionName,
                                                  style: TextStyle(
                                                    fontSize: 16.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(77, 77, 77, 1)
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'CLABE',
                                                  style: TextStyle(
                                                    fontSize: 16.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(77, 77, 77, 1)
                                                  ),
                                                ),
                                                Text(
                                                  this.state.user.clabe,
                                                  style: TextStyle(
                                                    fontSize: 16.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(77, 77, 77, 1)
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'No. de cuenta',
                                                  style: TextStyle(
                                                    fontSize: 16.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(77, 77, 77, 1)
                                                  ),
                                                ),
                                                Text(
                                                  this.state.user.accountNumber,
                                                  style: TextStyle(
                                                    fontSize: 16.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(77, 77, 77, 1)
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 15,
                                      height: 80,
                                      child: Container(
                                        width: 8,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(202, 206, 230, 1),
                                          borderRadius: BorderRadius.circular(4)
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 25, bottom: 5),
                                width: this.state.screen.width * .9,
                                child: Text(
                                  '¿Algún dato no es correcto?',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 102, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                width: this.state.screen.width * .9,
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Color.fromRGBO(77, 77, 77, 1),
                                    ),
                                    text: 'Contacta al área de recursos humanos de tu empresa o escribe un correo a ',
                                    children: [
                                      TextSpan(
                                        text: 'soporte@prestaqi.com',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        )
                                      )
                                    ]
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                )
            )
          )
        ],
      ),
    );
  }
}