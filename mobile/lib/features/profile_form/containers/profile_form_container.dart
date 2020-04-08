import 'package:flutter/material.dart';

import 'package:mobile/features/form/containers/form_container.dart'
    show FormContainer;
import 'package:mobile/features/form/models/form_field_controller_model.dart'
    show FormFieldController;
import 'package:mobile/features/form/models/on_form_submit_type.dart'
    show OnFormSubmit;

import '../configs/profile_form_config.dart' show profileFormConfig;
import '../mocks/team_avatars_mock.dart' show teamMock;
import '../widgets/profile_form_widget.dart' show ProfileForm;

class _ProfileFormContainer extends StatelessWidget {
  final Map<String, FormFieldController> controllers;
  final OnFormSubmit handleSubmit;

  _ProfileFormContainer({this.controllers, this.handleSubmit});

  void onFormSubmit() {
    final result = handleSubmit();
    print(result);
  }

  @override
  Widget build(BuildContext context) => ProfileForm(
      controllers: controllers, team: teamMock, onFormSubmit: onFormSubmit);
}

Widget createProfileContainer(controllers, OnFormSubmit handleSubmit) =>
    _ProfileFormContainer(controllers: controllers, handleSubmit: handleSubmit);

final profileFormContainer = FormContainer(
    controllers: profileFormConfig, createChild: createProfileContainer);
