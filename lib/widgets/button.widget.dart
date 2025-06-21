import 'package:flutter/material.dart';

Widget buttonWidget({
  required BuildContext context,
  required String label,
  Function()? onPress,
  Stream<bool>? stream,
  bool filled = false,
  bool? disabled = false,
  Color? bgColor,
  Color? txtColor,
  double? elevation
}) {
  Color bgColorO = bgColor ?? Theme.of(context).hintColor;
  Color txtColorO = txtColor ?? Theme.of(context).hintColor;

  if (stream == null) {
    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        elevation: elevation != null ? WidgetStateProperty.resolveWith<double>((states) => elevation) : null,
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          return filled ? bgColorO : Colors.transparent;
        }),
        textStyle: WidgetStateProperty.all(TextStyle(
          color: filled ? txtColorO : Colors.transparent,
          fontWeight: FontWeight.w600
        )),
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 13))
      ),
      child: Center(child: Text(label, style: TextStyle(color: txtColorO),))
    );
  }

  return StreamBuilder(
    stream: stream,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      return ElevatedButton(
        onPressed: snapshot.hasData && snapshot.data! ? null : onPress,
        style: ButtonStyle(
          elevation: elevation != null ? WidgetStateProperty.resolveWith<double>((states) => elevation) : null,
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            return filled ? bgColorO : Colors.transparent;
          }),
          textStyle: WidgetStateProperty.all(TextStyle(
            color: filled ? txtColorO : Colors.transparent,
            fontWeight: FontWeight.w600
          )),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 15))
        ),
        child: Container(
          child: snapshot.hasData && snapshot.data!
                    ? Align(
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation(
                                    filled ? Colors.white : Theme.of(context).primaryColor))),
                      )
                    : Center(child: Text(label, style: TextStyle(color: txtColorO))),
        ),
      );
    },
  );
}