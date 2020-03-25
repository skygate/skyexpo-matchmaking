import 'package:flutter/material.dart';

import 'package:mobile/core/widgets/auth_layout_widget.dart' show AuthLayout;
import 'log_in_form_fields_widget.dart' show LogInFormFields;
import 'auth_form_header_widget.dart' show AuthFormHeader;

typedef void Redirect({String name, String value});

class LogInForm extends StatelessWidget {
  final Function(dynamic) onFormSubmit;

  LogInForm({Key key, @required this.onFormSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AuthFormHeader(
            title: "Sign up", subTitle: "skyexpo matchmaking platform"),
        LogInFormFields(
          onFormSubmit: onFormSubmit,
        ),
      ],
    ));
  }
}
