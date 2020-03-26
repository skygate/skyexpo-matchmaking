import 'package:flutter/material.dart';

import 'package:mobile/common/validators/index.dart'
    show isNotEmptyValidator, isValidEmailValidator, isValidPasswordValidator;
import 'form_text_field_widget.dart' show FormTextField;

class AuthFormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function setFormFieldValue;
  final Map<String, String> formData;
  final bool isRegisterForm;

  AuthFormFields(
      {@required this.setFormFieldValue,
      @required this.formKey,
      @required this.formData,
      @required this.isRegisterForm});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          if (isRegisterForm)
            FormTextField(
              fieldId: 'name',
              label: "Name",
              setFormFieldValue: setFormFieldValue,
              formValues: formData,
              validators: [isNotEmptyValidator],
            ),
          FormTextField(
            fieldId: 'email',
            label: "Email address",
            setFormFieldValue: setFormFieldValue,
            formValues: formData,
            validators: [isNotEmptyValidator, isValidEmailValidator],
          ),
          FormTextField(
              fieldId: 'password',
              label: "Password",
              setFormFieldValue: setFormFieldValue,
              formValues: formData,
              validators: [isNotEmptyValidator, isValidPasswordValidator],
              isObscureText: true),
        ],
      ),
    );
  }
}
