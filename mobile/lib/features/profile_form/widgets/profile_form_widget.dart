import 'package:flutter/material.dart';

import 'package:mobile/core/widgets/auth_layout_widget.dart' show AuthLayout;
import 'package:mobile/features/auth/widgets/submit_button_widget.dart'
    show SubmitButton;
import 'profile_form_fields_widget.dart';

class ProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map profileFormData;
  final Function setFormFieldValue;
  final Function onFormSubmit;

  ProfileForm({
    @required this.formKey,
    @required this.profileFormData,
    @required this.setFormFieldValue,
    @required this.onFormSubmit,
  });

  @override
  Widget build(BuildContext context) => AuthLayout(
        topChild: Column(children: [
          Text('header'),
          ProfileFormFields(
            formKey: formKey,
            formData: profileFormData,
            setFormFieldValue: setFormFieldValue,
          )
        ]),
        bottomChild: SubmitButton(
          label: 'Done',
          onPressed: onFormSubmit,
        ),
      );
}
