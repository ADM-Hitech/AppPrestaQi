import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../providers/app.provider.dart';
import '../services/navigation.service.dart';
import '../services/setup.service.dart';

class ActionMenuAlert extends StatefulWidget {
  const ActionMenuAlert({super.key});

  @override
  ActionMenuAlertState createState() => ActionMenuAlertState();
}

class ActionMenuAlertState extends State<ActionMenuAlert> with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  int prevCountAlert = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    final Animation<double> offsetAnimation = 
      Tween(begin: 0.0, end: 10.0).chain(CurveTween(curve: Curves.elasticIn)).animate(animationController)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            animationController.reverse();
          }
        });

    if (AppProvider.of(context)!.countNotification != prevCountAlert) {
      animationController.forward(from: 0.0);
    }

    prevCountAlert = AppProvider.of(context)!.countNotification;

    return GestureDetector(
      onTap: () {
        appService<NavigationService>().navigateTo('notification');
      },
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.only(right: 20),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              child: AnimatedBuilder(
                animation: offsetAnimation,
                builder: (bc, child) {
                  return SvgPicture.asset(
                    'assets/icons/ico-notificaciones-nuevo.svg',
                    color: offsetAnimation.value != 0 ? Colors.yellowAccent : Colors.white,
                    width: 25 + offsetAnimation.value,
                  );
                },
              ),
            ),
            if (AppProvider.of(context)!.countNotification > 0) 
              Positioned(
                top: 17,
                right: 8,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(4.5)
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}