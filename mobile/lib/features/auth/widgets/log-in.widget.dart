import 'package:flutter/material.dart';

import 'package:mobile/common/validators/getValidators.validator.dart';
import 'package:mobile/common/validators/isNotEmpty.validator.dart';
import 'package:mobile/common/validators/isValidEmail.validator.dart';
import 'package:mobile/common/validators/isValidPassword.validator.dart';

import 'package:mobile/features/auth/models/credentails.model.dart';

class LogInForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String title;
  final Function(Credentials) onFormSubmit;
  final Credentials _formData = new Credentials();

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
