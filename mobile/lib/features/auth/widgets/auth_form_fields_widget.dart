import 'package:flutter/material.dart';

import 'package:mobile/features/form/models/form_field_controller_model.dart'
    show FormFieldController;
import 'package:mobile/features/form/widgets/form_text_field_widget.dart'
    show FormTextField;
import 'form_password_field.dart' show FormPasswordField;

class AuthFormFields extends StatelessWidget {
  final Map<String, FormFieldController> controllers;
  final bool isRegisterForm;

  AuthFormFields({@required this.controllers, @required this.isRegisterForm});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (isRegisterForm)
          FormTextField(
            label: "Name",
            controller: controllers['name'],
          ),
        FormTextField(
          label: "Email address",
          controller: controllers['email'],
        ),
        FormPasswordField(
          label: "Password",
          controller: controllers['password'],
        ),
      ],
    );
  }
}
