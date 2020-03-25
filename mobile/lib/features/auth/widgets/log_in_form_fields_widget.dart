import 'package:flutter/material.dart';
import 'package:mobile/common/validators/index.dart'
    show isNotEmptyValidator, isValidEmailValidator, isValidPasswordValidator;

import 'form_text_field_widget.dart';

class LogInFormFields extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Function setFormFieldValue;
  final Function onFormSubmit;

  LogInFormFields({this.setFormFieldValue, this.onFormSubmit});

  void submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      onFormSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FormTextField(
            fieldId: 'email',
            label: "Email",
            setFormFieldValue: setFormFieldValue,
            validators: [isNotEmptyValidator, isValidEmailValidator],
          ),
          FormTextField(
              fieldId: 'password',
              label: "Password",
              setFormFieldValue: setFormFieldValue,
              validators: [isNotEmptyValidator, isValidPasswordValidator],
              isObscureText: true),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: submitForm,
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
