import 'package:flutter/material.dart';

import 'package:mobile/features/form/models/form_field_controller_model.dart'
    show FormFieldController;
import 'package:mobile/features/form/widgets/form_text_field_widget.dart'
    show FormTextField;

class FormPasswordField extends StatefulWidget {
  final String label;
  final FormFieldController controller;

  FormPasswordField({
    @required this.label,
    @required this.controller,
  });

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
      label: widget.label,
      controller: widget.controller,
      isObscureText: isObscureText,
      suffix: GestureDetector(
        onTap: togglePasswordPreview,
        child: Icon(Icons.remove_red_eye),
      ));
}
