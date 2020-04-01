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
  _FormPasswordFieldState createState() => _FormPasswordFieldState();
}

class _FormPasswordFieldState extends State<FormPasswordField> {
  bool isObscureText;

  @override
  void initState() {
    super.initState();
    isObscureText = true;
  }

  void togglePasswordPreview() => setState(() {
        isObscureText = !isObscureText;
      });

  @override
  Widget build(BuildContext context) => FormTextField(
      fieldId: widget.fieldId,
      label: widget.label,
      setFormFieldValue: widget.setFormFieldValue,
      formValues: widget.formValues,
      validators: widget.validators,
      isObscureText: isObscureText,
      suffix: GestureDetector(
        onTap: togglePasswordPreview,
        child: Icon(Icons.remove_red_eye),
      ));
}
