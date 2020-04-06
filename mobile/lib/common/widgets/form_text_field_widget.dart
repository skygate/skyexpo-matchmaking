import 'package:flutter/material.dart';

import 'package:mobile/common/helpers/compose_validators_helper.dart'
    show composeValidators;
import 'package:mobile/common/models/form_field_controller_model.dart';
import 'package:mobile/common/widgets/form_field_wrapper_widget.dart';
import 'package:mobile/config/index.dart' show AppColor;

InputDecoration getInputDecorator(Widget suffix) => InputDecoration(
    filled: true,
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    fillColor: AppColor.inputBackground.value,
    suffix: suffix);

class FormTextField extends StatelessWidget {
  final String label;
  final String fieldId;
  final Function setFormFieldValue;
  final Iterable<Function> validators;
  final bool isObscureText;
  final Map<String, String> formValues;
  final Widget suffix;
  final FormFieldController controller;

  FormTextField(
      {@required this.label,
      @required this.fieldId,
      @required this.setFormFieldValue,
      @required this.formValues,
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
        // onChanged: (value) => setFormFieldValue(fieldId, value),
        // validator: (_) => composeValidators(validators, formValues[fieldId]),
      ),
    );
  }
}
