import 'dart:async';
import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show FontSize;
import '../models/form_field_controller_model.dart' show FormFieldController;
import 'form_field_error_widget.dart' show FormFieldError;

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
  StreamSubscription<dynamic> valueSubscription;
  StreamSubscription<bool> touchSubscription;

  void refresh() => setState(() {});

  @override
  void initState() {
    super.initState();

    valueSubscription = widget.controller.valueSubject.listen((_) => refresh());
    touchSubscription =
        widget.controller.touchedSubject.listen((_) => refresh());
  }

  @override
  void dispose() {
    valueSubscription.cancel();
    touchSubscription.cancel();

    super.dispose();
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
