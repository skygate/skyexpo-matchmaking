import 'package:flutter/material.dart';

import 'package:mobile/common/helpers/compose_validators_helper.dart'
    show composeValidators;
import 'package:mobile/common/validators/id_valid_password_validator.dart'
    show isValidPasswordValidator;
import 'package:mobile/common/validators/is_not_empty_validator.dart'
    show isNotEmptyValidator;
import 'package:mobile/common/validators/is_valid_email_validator.dart'
    show isValidEmailValidator;
import 'package:mobile/features/auth/models/credentails_model.dart'
    show Credentials;

class LogInForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String title;
  final Function(Credentials) onFormSubmit;
  final Credentials _formData = Credentials();

  LogInForm({Key key, @required this.title, @required this.onFormSubmit})
      : super(key: key);

  void submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      onFormSubmit(this._formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(title, style: TextStyle(fontSize: 20)),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        onSaved: (String value) {
                          this._formData.email = value;
                        },
                        validator: (value) => composeValidators(
                            [isNotEmptyValidator, isValidEmailValidator],
                            value),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        onSaved: (String value) {
                          this._formData.password = value;
                        },
                        obscureText: true,
                        validator: (value) => composeValidators(
                            [isNotEmptyValidator, isValidPasswordValidator],
                            value),
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
