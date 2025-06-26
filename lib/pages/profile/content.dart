import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prestaqi/pages/profile/page.dart';
import 'package:prestaqi/utils/hexcolor.dart';

Widget profileBody({
  required ProfileState state
}) {
  double width = MediaQuery.of(state.context).size.width;
  double height = MediaQuery.of(state.context).size.height;

  return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: 290,
              width: width,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#1292ff'),
                image: const DecorationImage(
                  image: AssetImage('assets/images/background_header.png'),
                  fit: BoxFit.none,
                  alignment: Alignment.bottomCenter
                )
              )
            ),
          ),
          Positioned(
            top: 125,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#eff4ff'),
                borderRadius: const BorderRadius.only(topRight: Radius.circular(70)),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 102, .4),
                    spreadRadius: 5,
                    blurRadius: 50,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              child: state.loading ?
                const Center(
                  child: CircularProgressIndicator(),
                )
              :
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      width: width,
                      height: 150,
                      decoration: BoxDecoration(
                        color: HexColor.fromHex('#000066'),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(65)
                        )
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            margin: const EdgeInsets.only(right: 25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              gradient: LinearGradient(
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
                                state.letterName(),
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white
                                )
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width - 175,
                                child: Text(
                                  '${state.user.firstName} ${state.user.lastName}', 
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.white
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'ID ${state.user.id.toString().padLeft(6, '0')}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ),
                    SizedBox(
                      width: width,
                      height: height - 255,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        physics: const BouncingScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (cntx, i) {
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 25),
                                width: width * .8,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 15),
                                      child: SvgPicture.asset(
                                        'assets/icons/ico-perfil-user.svg',
                                        colorFilter: ColorFilter.mode(const Color.fromRGBO(40, 101, 255, 1), BlendMode.srcIn),
                                        width: 22,
                                      ),
                                    ),
                                    const Text(
                                      'DATOS PERSONALES',
                                      style: TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                        fontWeight: FontWeight.w600
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: width * .9,
                                margin: const EdgeInsets.only(top: 15),
                                height: 90,
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      padding: const EdgeInsets.only(left: 25),
                                      width: width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(13),
                                        boxShadow: const [
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
                                          Text(
                                            '${state.user.firstName} ${state.user.lastName}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(77, 77, 77, 1)
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            state.user.mail,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(77, 77, 77, 1)
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
                                          color: const Color.fromRGBO(202, 206, 230, 1),
                                          borderRadius: BorderRadius.circular(4)
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (state.user.type == 3)
                                Container(
                                  padding: const EdgeInsets.only(top: 25),
                                  width: width * .8,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 15),
                                        child: SvgPicture.asset(
                                          'assets/icons/ico-perfil-tarjeta.svg',
                                          colorFilter: ColorFilter.mode(const Color.fromRGBO(40, 101, 255, 1), BlendMode.srcIn),
                                          width: 22,
                                        ),
                                      ),
                                      const Text(
                                        'DATOS DE NÓMINA',
                                        style: TextStyle(
                                          color: Color.fromRGBO(77, 77, 77, 1),
                                          fontWeight: FontWeight.w600
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ,
                              if (state.user.type == 3)
                                Container(
                                  width: width * .9,
                                  margin: const EdgeInsets.only(top: 15),
                                  height: 110,
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 4),
                                        padding: const EdgeInsets.only(left: 25, right: 25),
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(13),
                                          boxShadow: const [
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
                                            Text(
                                              state.user.companyName,
                                              style: const TextStyle(
                                                fontSize: 16.5,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(77, 77, 77, 1)
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text(
                                                  'Esquema de pago',
                                                  style: TextStyle(
                                                    fontSize: 16.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(77, 77, 77, 1)
                                                  ),
                                                ),
                                                Text(
                                                  state.user.periodName,
                                                  style: const TextStyle(
                                                    fontSize: 16.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(77, 77, 77, 1)
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text(
                                                  'Sueldo mensual neto',
                                                  style: TextStyle(
                                                    fontSize: 16.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(77, 77, 77, 1)
                                                  ),
                                                ),
                                                Text(
                                                  '\$${state.numberFormat.format(state.user.netMonthlySalary)}',
                                                  style: const TextStyle(
                                                    fontSize: 16.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(77, 77, 77, 1)
                                                  ),
                                                )
                                              ],
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
                                            color: const Color.fromRGBO(202, 206, 230, 1),
                                            borderRadius: BorderRadius.circular(4)
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ,
                              Container(
                                padding: const EdgeInsets.only(top: 25),
                                width: width * .8,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 15),
                                      child: SvgPicture.asset(
                                        'assets/icons/ico-perfil-datos.svg',
                                        colorFilter: ColorFilter.mode(const Color.fromRGBO(40, 101, 255, 1), BlendMode.srcIn),
                                        width: 22,
                                      ),
                                    ),
                                    const Text(
                                      'DATOS BANCARIOS',
                                      style: TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                        fontWeight: FontWeight.w600
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: width * .9,
                                margin: const EdgeInsets.only(top: 15),
                                height: 110,
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      padding: const EdgeInsets.only(left: 25, right: 25),
                                      width: width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(13),
                                        boxShadow: const [
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
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Banco',
                                                style: TextStyle(
                                                  fontSize: 16.5,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(77, 77, 77, 1)
                                                ),
                                              ),
                                              Text(
                                                state.user.institutionName,
                                                style: const TextStyle(
                                                  fontSize: 16.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(77, 77, 77, 1)
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'CLABE',
                                                style: TextStyle(
                                                  fontSize: 16.5,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(77, 77, 77, 1)
                                                ),
                                              ),
                                              Text(
                                                state.user.clabe,
                                                style: const TextStyle(
                                                  fontSize: 16.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(77, 77, 77, 1)
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'No. de cuenta',
                                                style: TextStyle(
                                                  fontSize: 16.5,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(77, 77, 77, 1)
                                                ),
                                              ),
                                              Text(
                                                state.user.accountNumber,
                                                style: const TextStyle(
                                                  fontSize: 16.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(77, 77, 77, 1)
                                                ),
                                              )
                                            ],
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
                                          color: const Color.fromRGBO(202, 206, 230, 1),
                                          borderRadius: BorderRadius.circular(4)
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 25, bottom: 5),
                                width: width * .9,
                                child: const Text(
                                  '¿Algún dato no es correcto?',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 102, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              if (state.user.type == 2) ...[
                                SizedBox(
                                  width: width * .9,
                                  child: RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                      ),
                                      text: 'Para cualquier aclaración o modificación de datos escribe un correo a ',
                                      children: [
                                        TextSpan(
                                          text: 'soporte@prestaqi.com',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          )
                                        ),
                                        TextSpan(
                                          text: ' y un ejecutivo se pondrá en contacto contigo.'
                                        )
                                      ]
                                    ),
                                  ),
                                )
                              ] else ...[
                                SizedBox(
                                  width: width * .9,
                                  child: RichText(
                                    text: const TextSpan(
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
                              SizedBox(height: 100)
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