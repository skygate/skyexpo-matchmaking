import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show AppRoute, FontSize, redirect;
import 'package:mobile/core/widgets/auth_layout_widget.dart' show AuthLayout;
import '../models/index.dart' show Credentials;
import 'log_in_form_fields_widget.dart' show LogInFormFields;
import 'auth_form_header_widget.dart' show AuthFormHeader;
import 'submit_button_widget.dart' show SubmitButton;

typedef void Redirect({String name, String value});

class LogInForm extends StatefulWidget {
  final Function onFormSubmit;
  LogInForm({Key key, @required this.onFormSubmit}) : super(key: key);

  @override
  _LogInFormFieldsState createState() =>
      new _LogInFormFieldsState(onFormSubmit: onFormSubmit);
}

class _LogInFormFieldsState extends State<LogInForm> {
  final Function onFormSubmit;
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _loginFormData;
  _LogInFormFieldsState({Key key, @required this.onFormSubmit});

  @override
  void initState() {
    super.initState();
    _loginFormData = {"email": '', "password": ''};
  }

  void _setFormFieldValue(String fieldId, String value) => setState(() {
        _loginFormData[fieldId] = value;
      });

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      onFormSubmit(Credentials(
          email: _loginFormData['email'],
          password: _loginFormData['password']));
    }
  }

  @override
  Widget build(BuildContext context) => AuthLayout(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AuthFormHeader(
              title: "Sign up", subTitle: "skyexpo matchmaking platform"),
          LogInFormFields(
            setFormFieldValue: _setFormFieldValue,
            formKey: _formKey,
            loginFormData: _loginFormData,
          ),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SubmitButton(
              label: 'Sign in',
              onPressed: _submitForm,
            ),
          ),
          GestureDetector(
              onTap: () => redirect(AppRoute.home),
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Center(
                    child: Text(
                  "Don't have account? Sign in.",
                  style: TextStyle(fontSize: FontSize.small.value),
                )),
              ))
        ],
      ));
}
