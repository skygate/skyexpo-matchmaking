import 'package:flutter/material.dart';

import 'package:mobile/core/widgets/auth_layout_widget.dart' show AuthLayout;
import 'package:mobile/features/auth/widgets/submit_button_widget.dart'
    show SubmitButton;

class ProfileForm extends StatelessWidget {
  final Function onFormSubmit;

  ProfileForm({
    @required this.onFormSubmit,
  });

  @override
  Widget build(BuildContext context) => AuthLayout(
        topChild: Column(children: [
          Text('header'),
        ]),
        bottomChild: SubmitButton(
          label: 'Done',
          onPressed: onFormSubmit,
        ),
      );
}
