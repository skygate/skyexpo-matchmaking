import 'package:flutter/material.dart';

import 'package:mobile/config/colors_config.dart' show AppColor;
import '../models/form_field_controller_model.dart' show FormFieldController;

class FormFieldError extends StatelessWidget {
  final FormFieldController controller;

  FormFieldError({this.controller});

  @override
  Widget build(BuildContext context) {
    final errors = controller.errors;
    bool isErrorVisible = errors.isNotEmpty && controller.touchedSubject.value;

    return Container(
        child: Text(
      isErrorVisible ? errors.values.first : '',
      style: TextStyle(color: AppColor.danger.value),
    ));
  }
}
