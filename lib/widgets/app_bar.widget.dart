import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prestaqi/widgets/action_menu_alert.widget.dart';

AppBar appBar({
  required BuildContext context,
  String title = '',
  Color bgColor = Colors.transparent,
  Color textColor = const Color.fromRGBO(143, 146, 163, 1)
}) {
  return AppBar(
    backgroundColor: bgColor,
    elevation: 0.0,
    centerTitle: true,
    iconTheme: title != '' ? IconThemeData(color: textColor) : IconThemeData(color: Colors.white),
    title: title != '' ? Text(title, style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w600
      )) : SvgPicture.asset(
      'assets/icons/ico-logo.svg',
      color: Colors.white,
      width: 110,
    ),
    actions: title != '' ? [] : const [
      ActionMenuAlert()
    ],
  );
}