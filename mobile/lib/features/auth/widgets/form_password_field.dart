import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'form_text_field_widget.dart' show FormTextField;

class FormPasswordField extends StatefulWidget {
  final String label;
  final String fieldId;
  final Function setFormFieldValue;
  final Iterable<Function> validators;
  final Map<String, String> formValues;

  FormPasswordField(
      {@required this.label,
      @required this.fieldId,
      @required this.setFormFieldValue,
      @required this.formValues,
      this.validators});

  @override
  _FormPasswordFieldState createState() => new _FormPasswordFieldState(
      fieldId: fieldId,
      label: label,
      setFormFieldValue: setFormFieldValue,
      formValues: formValues,
      validators: validators);
}

class _FormPasswordFieldState extends State<FormPasswordField> {
  final String label;
  final String fieldId;
  final Function setFormFieldValue;
  final Iterable<Function> validators;
  final Map<String, String> formValues;
  bool isObscureText;

  _FormPasswordFieldState(
      {@required this.label,
      @required this.fieldId,
      @required this.setFormFieldValue,
      @required this.formValues,
      this.validators});

  @override
  void initState() {
    super.initState();
    isObscureText = true;
  }

  void togglePasswordPreview() => setState(() {
        isObscureText = !isObscureText;
      });

  @override
  Widget build(BuildContext context) {
    return FormTextField(
        fieldId: fieldId,
        label: label,
        setFormFieldValue: setFormFieldValue,
        formValues: formValues,
        validators: validators,
        isObscureText: isObscureText,
        suffix: GestureDetector(
          onTap: togglePasswordPreview,
          child: Icon(Icons.remove_red_eye),
        ));
  }
}
