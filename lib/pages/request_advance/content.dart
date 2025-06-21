import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:prestaqi/pages/request_advance/page.dart';
import 'package:prestaqi/utils/hexcolor.dart';
import 'package:intl/intl.dart';

Widget requestAdvanceBody({
  required RequestAdvanceState state
}) {
  double width = MediaQuery.of(state.context).size.width;
  double height = MediaQuery.of(state.context).size.height;

  return GestureDetector(
    onTap: () {
      FocusScope.of(state.context).requestFocus(FocusNode());
    },
    child: SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: state.getHightTitle(height),
              width: width,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#1292ff'),
                image: const DecorationImage(
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
                    child: Text(
                      'Solicitar\r\nadelanto', 
                      style: TextStyle(
                        color: Colors.white, 
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: state.getSizeTitle(height)
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: state.getTopBody(height),
              child: Container(
                width: width,
                height: height - state.getTopBody(height),
                padding: const EdgeInsets.all(25),
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
                child: ListView.builder(
                  padding: EdgeInsets.only(top: state.getSpacesBetween(height), left: 0, right: 0, bottom: 0),
                  physics: const BouncingScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (cntx, i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          '¿Cuánto dinero necesitas?', 
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 26.5,
                            color: Color.fromRGBO(0, 0, 102, 1)
                          )
                        ),
                        SizedBox(
                          height: state.getSpacesBetween(height) + 15,
                        ),
                        if (state.isFixedPayments)
                          const Text('Montos Válidos: 3,000 | 5,000 | 10,000', style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            color: Color.fromRGBO(0, 0, 102, 1)
                          ))
                        ,
                        const SizedBox(height: 8),
                        Container(
                          height: 90,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromRGBO(222, 227, 237, 1),
                              width: 3
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
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
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(239, 244, 255, 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16)
                                  )
                                ),
                                child: const Text('\$',
                                  style: TextStyle(
                                    color: Color.fromRGBO(202, 206, 230, 1),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25
                                  )
                                )
                              ),
                              Form(
                                child: SizedBox(
                                  width: width - 200,
                                  child: TextFormField(
                                    controller: state.valueControl,
                                    textInputAction: TextInputAction.done,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    onChanged: state.updateValueWithInput,
                                    style: TextStyle(
                                      color: state.colorAmount,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none
                                    )
                                  ),
                                ),
                              ),
                              Container(
                                width: 80,
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  'assets/icons/ico-teclado.svg',
                                  color: const Color.fromRGBO(202, 206, 230, 1),
                                  width: 40,
                                )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: state.getSpacesBetweenSlide(height),
                        ),
                        if (state.loading) ...[
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        ]
                        else ...[
                          if (state.isBlocked) ...[
                            const Center(
                              child: Text('Servicio bloqueado', style: TextStyle(fontSize: 18, color: Colors.red)),
                            )
                          ] else if (state.insufficientBalance) ...[
                            const Center(
                              child: Text('No cuentas con saldo disponible para solicitar un adelanto.', style: TextStyle(fontSize: 18, color: Colors.red), textAlign: TextAlign.center,),
                            ),
                          ] else if (state.errorMessage != '') ...[
                            Center(
                              child: Text(state.errorMessage, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red), textAlign: TextAlign.center,),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Center(
                              child: FilledButton.icon(
                                onPressed: state.requestActiveLocation,
                                label: Text('Activar Ubicación', style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                )),
                                icon: Icon(Icons.replay_outlined),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(HexColor.fromHex('#000066')),
                                ),
                              ),
                            )
                          ] else ...[
                            SizedBox(
                              width: width,
                              child: SliderTheme(
                                data: SliderTheme.of(state.context).copyWith(
                                  activeTrackColor: const Color.fromRGBO(51, 51, 254, 1),
                                  inactiveTrackColor: const Color.fromRGBO(202, 206, 230, 1),
                                  thumbColor: const Color.fromRGBO(51, 51, 254, 1),
                                ),
                                child: FlutterSlider(
                                  min: 0,
                                  max: state.maxValue,
                                  step: FlutterSliderStep(
                                    step: state.isFixedPayments ? 1000 : 50,
                                    /*rangeList: state.isFixedPayments ? [
                                      FlutterSliderRangeStep(from: 0, to: 3000, step: 3000),
                                      FlutterSliderRangeStep(from: 3000, to: 5000, step: 2000),
                                      FlutterSliderRangeStep(from: 5000, to: 10000, step: 5000)
                                    ] : [],*/
                                  ),
                                  /*ignoreSteps: state.isFixedPayments ? [
                                    FlutterSliderIgnoreSteps(from: 0, to: 2000),
                                    FlutterSliderIgnoreSteps(from: 3100, to: 4000),
                                    FlutterSliderIgnoreSteps(from: 6000, to: 9000),
                                  ] : [],*/
                                  values: state.isFixedPayments ? [state.valueAdvance / 100] : [state.valueAdvance],
                                  fixedValues: state.isFixedPayments ? [
                                    FlutterSliderFixedValue(percent: 0, value: 0.0),
                                    FlutterSliderFixedValue(percent: 30, value: 3000.0),
                                    FlutterSliderFixedValue(percent: 50, value: 5000.0),
                                    FlutterSliderFixedValue(percent: 100, value: 10000.0),
                                  ] : null,
                                  hatchMark: state.isFixedPayments ? FlutterSliderHatchMark(
                                    density: 0.5,
                                    labels: [
                                      FlutterSliderHatchMarkLabel(percent: 0, label: Container(width: 16, height: 16, decoration: BoxDecoration(color: HexColor.fromHex('#3333ff'), borderRadius: BorderRadius.circular(8)))),
                                      FlutterSliderHatchMarkLabel(percent: 30, label: Container(width: 16, height: 16, decoration: BoxDecoration(color: HexColor.fromHex('#3333ff'), borderRadius: BorderRadius.circular(8)))),
                                      FlutterSliderHatchMarkLabel(percent: 50, label: Container(width: 16, height: 16, decoration: BoxDecoration(color: HexColor.fromHex('#3333ff'), borderRadius: BorderRadius.circular(8)))),
                                      FlutterSliderHatchMarkLabel(percent: 100, label: Container(width: 16, height: 16, decoration: BoxDecoration(color: HexColor.fromHex('#3333ff'), borderRadius: BorderRadius.circular(8))))
                                    ],
                                  ) : null,
                                  tooltip: FlutterSliderTooltip(
                                    disabled: true,
                                  ),
                                  onDragging: (int i, dynamic value, dynamic c) {
                                    if (state.isFixedPayments) {
                                      double parseValue = value as double;
                                      if (parseValue == 0 || parseValue == 3000 || parseValue == 5000 || parseValue == 10000) {
                                        state.updateValueAdvance(parseValue);
                                      }

                                      return;
                                    }

                                    state.updateValueAdvance(value as double);
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
                              child: SizedBox(
                                width: width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('\$0', 
                                      style: TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23
                                      )
                                    ),
                                    Text('\$${NumberFormat.currency(symbol: '').format(state.maxValue)}',
                                    style: const TextStyle(
                                        color: Color.fromRGBO(77, 77, 77, 1),
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23
                                      )
                                    )
                                  ],
                                ),
                              ),  
                            ),
                            SizedBox(
                              height: state.getSpacesBetweenButton(height),
                            ),
                            Center(
                              child: Opacity(
                                opacity: state.errorAmount ? .6 : 1,
                                child: SizedBox(
                                  width: width * .8,
                                  child: GestureDetector(
                                    onTap: state.requestAdvance,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 25),
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex('#000066'),
                                        borderRadius: BorderRadius.circular(40)
                                      ),
                                      child: const Center(
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
        ]
      )
    ),
  );
}