import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show AppColor;
import 'package:mobile/features/form/models/form_field_controller_model.dart'
    show FormFieldController;

import 'form_field_wrapper_widget.dart';

InputDecoration getInputDecorator(Widget suffix) => InputDecoration(
    filled: true,
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    fillColor: AppColor.inputBackground.value,
    suffix: suffix);

class FormTextField extends StatelessWidget {
  final String label;
  final Iterable<Function> validators;
  final bool isObscureText;
  final Widget suffix;
  final FormFieldController controller;

  FormTextField(
      {@required this.label,
      @required this.controller,
      this.isObscureText = false,
      this.validators,
      this.suffix});

  @override
  Widget build(BuildContext context) {
    return FormFieldWrapper(
      label: label,
      controller: controller,
      child: TextFormField(
        decoration: getInputDecorator(suffix),
        obscureText: isObscureText,
        onChanged: controller.handleChange,
      ),
    );
  }
}
