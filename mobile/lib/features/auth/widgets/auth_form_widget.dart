import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show AppRoute;
import 'package:mobile/core/widgets/auth_layout_widget.dart' show AuthLayout;
import 'auth_switch_link_widget.dart' show AuthSwitchLink;
import 'auth_form_header_widget.dart' show AuthFormHeader;
import 'submit_button_widget.dart' show SubmitButton;

class AuthForm extends StatelessWidget {
  final String title;
  final String subTitle;
  final String switchLinkTitle;
  final AppRoute swichLinkRoute;
  final Function onFormSubmit;
  final Widget formWidget;

  AuthForm({
    @required this.title,
    @required this.subTitle,
    @required this.switchLinkTitle,
    @required this.swichLinkRoute,
    @required this.onFormSubmit,
    @required this.formWidget,
  });

  @override
  Widget build(BuildContext context) => AuthLayout(
        topChild: Column(children: <Widget>[
          AuthFormHeader(title: title, subTitle: subTitle),
          formWidget,
        ]),
        bottomChild: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SubmitButton(
              label: title,
              onPressed: onFormSubmit,
            ),
            AuthSwitchLink(title: switchLinkTitle, route: swichLinkRoute)
          ],
        ),
      );
}
