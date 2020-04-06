import 'package:flutter/material.dart';

import 'package:mobile/core/widgets/sliver_layout_widget.dart'
    show SliverLayout;
import 'package:mobile/config/colors_config.dart' show AppColor;
import 'package:mobile/common/widgets/submit_button_widget.dart'
    show SubmitButton;
import 'package:mobile/features/form/models/form_field_controller_model.dart';
import '../models/team_model.dart' show Team;
import 'profile_form_header.dart' show ProfileFormHeader;
import 'profile_form_fields_widget.dart' show ProfileFormFields;

class ProfileForm extends StatelessWidget {
  final Function onFormSubmit;
  final Team team;
  final Map<String, FormFieldController> controllers;

  ProfileForm(
      {@required this.onFormSubmit,
      @required this.team,
      @required this.controllers});

  @override
  Widget build(BuildContext context) => SliverLayout(
        topChild: Column(children: [
          ProfileFormHeader(
            team: team,
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Divider(
                color: AppColor.divider.value,
                thickness: 1,
              )),
          ProfileFormFields(
            controllers: controllers,
          )
        ]),
        bottomChild: SubmitButton(
          label: 'Done',
          onPressed: onFormSubmit,
        ),
      );
}
