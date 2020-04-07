import 'package:flutter/material.dart';

import 'package:mobile/config/colors_config.dart' show AppColor;
import 'package:mobile/config/fonts_config.dart' show FontSize;
import 'package:mobile/features/form/models/form_field_controller_model.dart';

class FormFieldError extends StatelessWidget {
  final FormFieldController controller;

  FormFieldError({this.controller});

  @override
  Widget build(BuildContext context) {
    final errors = controller.errors;
    print('sdf');
    print(controller.errors);
    print('sdf');

    bool isErrorVisible = errors.isNotEmpty && controller.touched;

    return Container(child: Text(isErrorVisible ? errors[0] : ''));
  }
}