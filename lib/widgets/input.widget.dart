import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';

Widget inputWidget<T>({
  required BuildContext context,
  required Stream<T> stream,
  required Function(String) onChange,
  TextEditingController? controller,
  String label = '',
  TextInputType? inputType,
  bool obscureText = false,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool filled = true,
  bool borderColor = false,
  Color? colorFill,
  Color? colorLabel,
  Color? colorBorder,
  int? maxLength,
  TextInputAction? inputAction,
  bool enabled = true,
  TextCapitalization textCapitalization = TextCapitalization.sentences,
  List<TextInputFormatter>? inputFormatters,
  String? error
}) {

  final oscureceController = BehaviorSubject<bool>();
  Color overrideColorFill = colorFill ?? Colors.white;
  Color overrideBorderColor = colorBorder ?? (borderColor ? const Color.fromRGBO(40, 168, 177, 1) : Colors.white);

  void viewText() {
    bool value = oscureceController.valueOrNull ?? false;
    oscureceController.sink.add(!value);
  }

  IconData getIcon(bool show) {
    return show ? Icons.remove_red_eye : Icons.visibility_off;
  }

  if (obscureText) {
    suffixIcon = GestureDetector(
      onTap: viewText,
      child: StreamBuilder(
        stream: oscureceController.stream,
        builder: (BuildContext ctx, AsyncSnapshot<bool> snapshot) {
          return Icon(getIcon(snapshot.hasData && snapshot.data!), color: Colors.white);
        },
      ),
    );
  }

  InputDecoration decoration(AsyncSnapshot snapshot) {
    if (!filled) {
      return InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        filled: true,
        fillColor: overrideColorFill,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: label,
        labelStyle: TextStyle(
          color: colorLabel ?? Theme.of(context).inputDecorationTheme.labelStyle!.color
        ),
        focusedBorder: borderColor ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: overrideBorderColor)
        ) : UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: overrideBorderColor)
        ),
        border: borderColor ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: overrideBorderColor)
        ) : null,
        enabledBorder: borderColor ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: overrideBorderColor),
        ) : null,
        errorText: error ?? (snapshot.hasError ? snapshot.error.toString() : null)
      );
    }

    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      filled: true,
      fillColor: overrideColorFill,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: filled ? '' : label,
      labelStyle: TextStyle(
        color: colorLabel ?? Theme.of(context).inputDecorationTheme.labelStyle!.color
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: overrideBorderColor)
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: overrideBorderColor)
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: overrideBorderColor)
      ),
      errorText: error ?? (snapshot.hasError ? snapshot.error.toString() : null)
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (filled) ...[
        Container(
          margin: const EdgeInsets.only(left: 15),
          child: Text(label, style: TextStyle(color: colorLabel ?? const Color.fromRGBO(40, 168, 177, 1)),),
        ),
        const SizedBox(height: 5,)
      ],
      StreamBuilder(
        stream: stream,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (obscureText) {
            return StreamBuilder(
              stream: oscureceController.stream,
              builder: (BuildContext ctxShow, AsyncSnapshot snpShow) {
                bool value = oscureceController.valueOrNull ?? false;

                return TextField(
                  controller: controller,
                  keyboardType: inputType,
                  obscureText: !value,
                  enableSuggestions: false,
                  decoration: decoration(snapshot),
                  onChanged: onChange,
                  maxLength: maxLength,
                  textInputAction: inputAction,
                  enabled: enabled,
                  textCapitalization: obscureText ? TextCapitalization.none : textCapitalization,
                  inputFormatters: inputFormatters,
                  style: const TextStyle(
                    color: Colors.white
                  ),
                );
              },
            );
          }

          return TextField(
            maxLength: maxLength,
            controller: controller,
            maxLines: inputType == TextInputType.multiline ? 7 : null,
            keyboardType: inputType,
            obscureText: obscureText ? oscureceController.valueOrNull ?? false : false,
            enableSuggestions: false,
            decoration: decoration(snapshot),
            onChanged: onChange,
            textInputAction: inputAction,
            enabled: enabled,
            textCapitalization: obscureText ? TextCapitalization.none : textCapitalization,
            inputFormatters: inputFormatters,
            cursorColor: Colors.white,
            style: const TextStyle(
              color: Colors.white
            ),
          );
        },
      )
    ],
  );
}