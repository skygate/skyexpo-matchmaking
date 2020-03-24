import 'package:flutter/material.dart';

import 'package:mobile/common/helpers/compose_validators_helper.dart'
    show composeValidators;
import 'package:mobile/common/validators/id_valid_password_validator.dart'
    show isValidPasswordValidator;
import 'package:mobile/common/validators/is_not_empty_validator.dart'
    show isNotEmptyValidator;
import 'package:mobile/common/validators/is_valid_email_validator.dart'
    show isValidEmailValidator;
import 'package:mobile/config/colors_config.dart' show AppColor;
import 'package:mobile/core/widgets/auth_layout_widget.dart' show AuthLayout;
import 'package:mobile/features/auth/models/credentails_model.dart'
    show Credentials;

import 'auth_form_header_widget.dart' show AuthFormHeader;

typedef void Redirect({String name, String value});

class LogInForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Function() onFormSubmit;
  final Function(String, String) setFormFieldValue;

  LogInForm(
      {Key key, @required this.onFormSubmit, @required this.setFormFieldValue})
      : super(key: key);

  void submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      onFormSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
        child: Center(
            child: Container(
                child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AuthFormHeader(
              title: "Sign up", subTitle: "skyexpo matchmaking platform"),
          Text("Test", style: TextStyle(fontSize: 20)),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Full name',
              filled: true,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              fillColor: AppColor.iputBackground.value,
            ),
            onSaved: (String value) {
              // this._formData.email = value;
              // this._formData['email'] = value;
              setFormFieldValue('email', value);

              // this._formData
            },
            validator: (value) => composeValidators(
                [isNotEmptyValidator, isValidEmailValidator], value),
          ),
          TextFormField(
            decoration:
                InputDecoration(fillColor: AppColor.iputBackground.value),
            onSaved: (String value) {
              // this._formData.password = value;
              setFormFieldValue('password', value);
            },
            obscureText: true,
            validator: (value) => composeValidators(
                [isNotEmptyValidator, isValidPasswordValidator], value),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: this.submitForm,
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    ))));
  }
}
