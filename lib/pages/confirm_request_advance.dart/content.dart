import 'package:flutter/material.dart';
import 'package:prestaqi/pages/confirm_request_advance.dart/page.dart';
import 'package:prestaqi/services/navigation.service.dart';
import 'package:prestaqi/services/setup.service.dart';

Widget confirmRequestAdvanceBody({required ConfirmRequestAdvanceState state}) {
  double width = MediaQuery.of(state.context).size.width;
  double height = MediaQuery.of(state.context).size.height;

  return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(60))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(239, 244, 255, 1),
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                        color: const Color.fromRGBO(222, 227, 237, 1),
                        width: 2)),
                padding: const EdgeInsets.all(40),
                width: width * .65,
                child: Column(
                  children: [
                    const Text(
                      'Cantidad solicitada',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(142, 145, 162, 1),
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      width: width * .65,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text('\$${state.getAmount()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 0, 102, 1))),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 7,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(202, 206, 230, 1),
                          borderRadius: BorderRadius.circular(3.5)),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: Container(
                              height: 7,
                              width: ((width * .65) - 80) * state.porcen,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(51, 51, 255, 1),
                                  borderRadius: BorderRadius.circular(3.5)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                width: width * .8,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(222, 227, 237, 1), width: 1),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Banco',
                              style: TextStyle(
                                  color: Color.fromRGBO(142, 145, 162, 1),
                                  fontSize: 18)),
                          Text(state.infoBank.institutionName,
                              style: const TextStyle(
                                  color: Color.fromRGBO(77, 77, 77, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(222, 227, 237, 1), width: 1),
                      )),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Cuenta',
                              style: TextStyle(
                                  color: Color.fromRGBO(142, 145, 162, 1),
                                  fontSize: 18)),
                          Text('**** **** ${state.getLast4Char()}',
                              style: const TextStyle(
                                  color: Color.fromRGBO(77, 77, 77, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(222, 227, 237, 1), width: 1),
                      )),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total a descontar',
                              style: TextStyle(
                                  color: Color.fromRGBO(142, 145, 162, 1),
                                  fontSize: 18)),
                          Text('\$${state.getAmountDiscount()}',
                              style: const TextStyle(
                                  color: Color.fromRGBO(77, 77, 77, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    if (state.detailsDates.isEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Fecha de cobro',
                                style: TextStyle(
                                    color: Color.fromRGBO(142, 145, 162, 1),
                                    fontSize: 18)),
                            Text(state.formatDate.format(state.dateNextPay),
                                style: const TextStyle(
                                    color: Color.fromRGBO(77, 77, 77, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    if (state.detailsDates.isNotEmpty) ...[
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: const Text('Fechas de cobro',
                              style: TextStyle(
                                  color: Color.fromRGBO(142, 145, 162, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))),
                      Column(
                        children: state.detailsDates
                            .map((detail) => Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                        color: Color.fromRGBO(222, 227, 237, 1),
                                        width: 1),
                                  )),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: state.pref.isFixedPayments ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          state.formatDate
                                              .format(detail.datePayment),
                                          style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(77, 77, 77, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      if (state.pref.isFixedPayments) ...[
                                        const Text('-'),
                                        Text('\$${state.formatCurrency(detail.totalPayment)}',
                                            style: const TextStyle(
                                                color:
                                                    Color.fromRGBO(77, 77, 77, 1),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ]
                                    ],
                                  ),
                                ))
                            .toList(),
                      )
                    ]
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            (state.loading)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: SizedBox(
                      width: width * .8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: (width * .8) / 2,
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: state.loading ? () {} : state.acepted,
                              child: Container(
                                height: 55,
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 102, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: const Center(
                                  child: Text('ACEPTAR',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: (width * .8) / 2,
                            padding: const EdgeInsets.only(left: 10),
                            child: GestureDetector(
                              onTap: () {
                                if (!state.loading) {
                                  appService<NavigationService>()
                                      .navigateTo('request-advance');
                                }
                              },
                              child: Container(
                                height: 55,
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(198, 200, 208, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: const Center(
                                  child: Text('RECHAZAR',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ));
}
