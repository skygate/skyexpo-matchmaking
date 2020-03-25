import 'package:flutter/material.dart';

import 'package:mobile/common/validators/index.dart'
    show isNotEmptyValidator, isValidEmailValidator, isValidPasswordValidator;
import 'form_text_field_widget.dart' show FormTextField;
import 'submit_button_widget.dart' show SubmitButton;

class LogInFormFields extends StatefulWidget {
  final Function onFormSubmit;
  LogInFormFields({Key key, this.onFormSubmit}) : super(key: key);

  @override
  _LogInFormFieldsState createState() => new _LogInFormFieldsState();
}

class _LogInFormFieldsState extends State<LogInFormFields> {
  final _formKey = GlobalKey<FormState>();
  final Function onFormSubmit;
  Map<String, String> loginFormData;

  _LogInFormFieldsState({this.onFormSubmit, this.loginFormData});

  @override
  void initState() {
    super.initState();
    loginFormData = {"email": '', "password": ''};
  }

  void setFormFieldValue(String fieldId, String value) => setState(() {
        loginFormData[fieldId] = value;
      });

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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SubmitButton(
              label: 'Sign in',
              onPressed: submitForm,
            ),
          ),
        ],
      ),
    );
  }
}
