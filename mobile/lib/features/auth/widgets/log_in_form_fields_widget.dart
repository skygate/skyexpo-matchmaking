import 'package:flutter/material.dart';

import 'package:mobile/common/validators/index.dart'
    show isNotEmptyValidator, isValidEmailValidator, isValidPasswordValidator;
import 'form_text_field_widget.dart' show FormTextField;

class LogInFormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function setFormFieldValue;
  final Map<String, String> loginFormData;

  LogInFormFields(
      {@required this.setFormFieldValue,
      @required this.formKey,
      @required this.loginFormData});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          FormTextField(
            fieldId: 'email',
            label: "Email address",
            setFormFieldValue: setFormFieldValue,
            formValues: loginFormData,
            validators: [isNotEmptyValidator, isValidEmailValidator],
          ),
          FormTextField(
              fieldId: 'password',
              label: "Password",
              setFormFieldValue: setFormFieldValue,
              formValues: loginFormData,
              validators: [isNotEmptyValidator, isValidPasswordValidator],
              isObscureText: true),
        ],
      ),
    );
  }
}
