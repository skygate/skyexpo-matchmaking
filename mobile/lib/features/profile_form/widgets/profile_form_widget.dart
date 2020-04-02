import 'package:flutter/material.dart';
import 'package:mobile/config/colors_config.dart';

import 'package:mobile/core/widgets/auth_layout_widget.dart' show AuthLayout;
import 'package:mobile/features/auth/widgets/submit_button_widget.dart'
    show SubmitButton;
import '../models/team_model.dart' show Team;
import 'profile_form_header.dart' show ProfileFormHeader;
import 'profile_form_fields_widget.dart' show ProfileFormFields;

class ProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map profileFormData;
  final Function setFormFieldValue;
  final Function onFormSubmit;
  final Team team;

  ProfileForm(
      {@required this.formKey,
      @required this.profileFormData,
      @required this.setFormFieldValue,
      @required this.onFormSubmit,
      @required this.team});

  @override
  Widget build(BuildContext context) => AuthLayout(
        topChild: Column(children: [
          ProfileFormHeader(
            team: team,
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 36),
              child: Divider(
                color: AppColor.divider.value,
                thickness: 1,
              )),
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
