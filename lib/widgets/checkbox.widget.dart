import 'package:flutter/material.dart';

Widget checkboxWidget({
  required BuildContext context,
  required Object label,
  required Stream<bool> stream,
  required Function(bool) onChange,
  Color? checkColor,
  Color? activeColor
}) {
  Color color = Theme.of(context).hintColor;

  return StreamBuilder(
    stream: stream,
    builder: (BuildContext ctx, AsyncSnapshot<bool> snp) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            checkColor: checkColor ?? Colors.white,
            activeColor: activeColor ?? color,
            value: snp.hasData && snp.data!,
            onChanged: (value) => onChange(value!),
          ),
          if (label is String) ...[
            Text(label)
          ] else if(label is Widget) ...[
            label
          ]
        ],
      );
    }
  );
}