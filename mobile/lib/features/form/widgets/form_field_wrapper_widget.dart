import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show FontSize;
import 'package:mobile/features/form/models/form_field_controller_model.dart';

import 'form_field_error_widget.dart';

class FormFieldWrapper extends StatefulWidget {
  final String label;
  final Widget child;
  final FormFieldController controller;

  FormFieldWrapper(
      {@required this.label, @required this.child, this.controller});

  @override
  _FormFieldWrapperState createState() => _FormFieldWrapperState();
}

class _FormFieldWrapperState extends State<FormFieldWrapper> {
  @override
  void initState() {
    super.initState();
    widget.controller.valueSubject.listen((value) {
      setState(() {}); //setState is  required to refresh widget on value change
    });
  }

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(widget.label,
                style: TextStyle(fontSize: FontSize.normal.value)),
            margin: EdgeInsets.only(bottom: 12),
          ),
          widget.child,
          FormFieldError(
            controller: widget.controller,
          )
        ],
      ));
}
