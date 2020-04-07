import 'package:flutter/material.dart';
// import 'package:mobile/common/models/form_field_controller_model.dart';
import 'package:mobile/features/form/containers/form_container.dart';
import 'package:mobile/features/form/models/form_field_controller_model.dart';
import 'package:mobile/features/profile_form/configs/profile_form_config.dart';
import 'package:mobile/features/profile_form/mocks/team_avatars_mock.dart';
import 'package:mobile/features/profile_form/widgets/profile_form_widget.dart';

class _ProfileFormContainer extends StatelessWidget {
  final Map<String, FormFieldController> controllers;

  _ProfileFormContainer({this.controllers});

  @override
  Widget build(BuildContext context) => ProfileForm(
      controllers: controllers, team: teamMock, onFormSubmit: () => {});
}

Widget createProfileContainer(controllers) {
  return _ProfileFormContainer(controllers: controllers);
}

final profileFormContainer =
    withForm(profileFormConfig, createProfileContainer);
