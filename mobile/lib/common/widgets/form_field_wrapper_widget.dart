import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show FontSize;

class FormFieldWrapper extends StatelessWidget {
  final String label;
  final Widget child;

  FormFieldWrapper({
    @required this.label,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) => Container(
      margin: new EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:
                Text(label, style: TextStyle(fontSize: FontSize.normal.value)),
            margin: EdgeInsets.only(bottom: 12),
          ),
          child,
        ],
      ));
}
