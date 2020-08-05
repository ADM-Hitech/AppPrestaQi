import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';
import 'package:prestaQi/Screens/RequestAdvance/request_advance.dart';

import '../../Utils/HexColor.dart';

class RequestAdvanceContent extends StatelessWidget{

  final RequestAdvanceState state;

  RequestAdvanceContent({Key key, @required this.state});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        height: this.state.screen.height,
        width: this.state.screen.width,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: this.state.getHightTitle(),
                width: this.state.screen.width,
                decoration: BoxDecoration(
                  color: HexColor.fromHex('#1292ff'),
                  image: DecorationImage(
                    image: AssetImage('assets/images/background_header.png'),
                    fit: BoxFit.none,
                    alignment: Alignment.bottomCenter
                  )
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 100,
                      left: 25,
                      child: Container(
                        child: Text(
                          'Solicitar\r\nadelanto', 
                          style: TextStyle(
                            color: Colors.white, 
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: this.state.getSizeTitle()
                          )
                        )
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: this.state.getTopBody(),
              child: Container(
                width: this.state.screen.width,
                height: this.state.screen.height - this.state.getTopBody(),
                padding: EdgeInsets.all(25),
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
                child: ListView.builder(
                  padding: EdgeInsets.only(top: this.state.getSpacesBetween(), left: 0, right: 0, bottom: 0),
                  physics: BouncingScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (cntx, i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            '¿Cuánto dinero necesitas?', 
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 26.5,
                              color: Color.fromRGBO(0, 0, 102, 1)
                            )
                          ),
                        ),
                        SizedBox(
                          height: this.state.getSpacesBetween() + 15,
                        ),
                        Container(
                          height: 90,
                          width: this.state.screen.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Color.fromRGBO(222, 227, 237, 1),
                              width: 3
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(203, 208, 232, 1),
                                spreadRadius: 5,
                                blurRadius: 30,
                                offset: Offset(-10, 20)
                              )
                            ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(239, 244, 255, 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16)
                                  )
                                ),
                                child: Text('\$',
                                  style: TextStyle(
                                    color: Color.fromRGBO(202, 206, 230, 1),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25
                                  )
                                )
                              ),
                              Form(
                                child: Container(
                                  width: this.state.screen.width - 200,
                                  child: TextFormField(
                                    controller: this.state.valueControl,
                                    textInputAction: TextInputAction.done,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    onChanged: this.state.updateValueWithInput,
                                    style: TextStyle(
                                      color: this.state.colorAmount,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none
                                    )
                                  ),
                                ),
                              ),
                              /*Container(
                                child: Text('\$${this.state.valueAdvance.toStringAsFixed(2)}', 
                                style: TextStyle(
                                    color: this.state.colorAmount,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30
                                  )
                                )
                              ),*/
                              Container(
                                width: 80,
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  'assets/icons/ico-teclado.svg',
                                  color: Color.fromRGBO(202, 206, 230, 1),
                                  width: 40,
                                )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: this.state.getSpacesBetweenSlide(),
                        ),
                        if (this.state.loading) ...[
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        ]
                        else ...[
                          if (this.state.isBlocked) ...[
                            Center(
                              child: Container(
                                child: Text('Servicio bloqueado', style: TextStyle(fontSize: 18, color: Colors.red),),
                              ),
                            )
                          ] else ...[
                            Container(
                              width: this.state.screen.width,
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Color.fromRGBO(51, 51, 254, 1),
                                  inactiveTrackColor: Color.fromRGBO(202, 206, 230, 1),
                                  thumbColor: Color.fromRGBO(51, 51, 254, 1)
                                ),
                                child: FlutterSlider(
                                  min: 0,
                                  max: this.state.maxValue,
                                  step: FlutterSliderStep(step: 50),
                                  values: [this.state.valueAdvance],
                                  tooltip: FlutterSliderTooltip(
                                    disabled: true,
                                  ),
                                  onDragging: (int i, dynamic value, dynamic c) => {
                                    this.state.updateValueAdvance(value as double)
                                  },
                                  trackBar: FlutterSliderTrackBar(
                                    activeTrackBarHeight: 10,
                                    inactiveTrackBarHeight: 10,
                                    activeTrackBar: BoxDecoration(
                                      color: HexColor.fromHex('#3333ff'),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    inactiveTrackBar: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)
                                    )
                                  ),
                                  handlerHeight: 30,
                                  handlerWidth: 30,
                                  handler: FlutterSliderHandler(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex('#3333ff'),
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      width: 30,
                                      height: 30,
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: HexColor.fromHex('#2865ff'),
                                            borderRadius: BorderRadius.circular(7)
                                          ),
                                          width: 14,
                                          height: 14,
                                        ),
                                      ),
                                    )
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: this.state.screen.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text('\$0', 
                                        style: TextStyle(
                                          color: Color.fromRGBO(77, 77, 77, 1),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23
                                        )
                                      ),
                                    ),
                                    Container(
                                      child: Text('\$${NumberFormat.currency(symbol: '').format(this.state.maxValue)}',
                                      style: TextStyle(
                                          color: Color.fromRGBO(77, 77, 77, 1),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23
                                        )
                                      ),
                                    )
                                  ],
                                ),
                              ),  
                            ),
                            SizedBox(
                              height: this.state.getSpacesBetweenButton(),
                            ),
                            Center(
                              child: Opacity(
                                opacity: this.state.errorAmount ? .6 : 1,
                                child: Container(
                                  width: this.state.screen.width * .8,
                                  child: GestureDetector(
                                    onTap: this.state.requestAdvance,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 25),
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex('#000066'),
                                        borderRadius: BorderRadius.circular(40)
                                      ),
                                      child: Center(
                                        child: Text(
                                          'SOLICITAR', 
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
                            )
                          ]
                        ]
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}