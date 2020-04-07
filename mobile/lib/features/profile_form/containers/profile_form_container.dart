import 'package:flutter/material.dart';
// import 'package:mobile/common/models/form_field_controller_model.dart';
import 'package:mobile/features/form/containers/form_container.dart';
import 'package:mobile/features/form/models/form_field_controller_model.dart';
import 'package:mobile/features/form/models/on_form_submit_type.dart';
import 'package:mobile/features/profile_form/configs/profile_form_config.dart';
import 'package:mobile/features/profile_form/mocks/team_avatars_mock.dart';
import 'package:mobile/features/profile_form/widgets/profile_form_widget.dart';

class _ProfileFormContainer extends StatelessWidget {
  final Map<String, FormFieldController> controllers;
  final Function handleSubmit;

  _ProfileFormContainer({this.controllers, this.handleSubmit});

  void onFormSubmit() {
    final result = handleSubmit();
    print(result);
  }

  @override
  Widget build(BuildContext context) => ProfileForm(
      controllers: controllers, team: teamMock, onFormSubmit: onFormSubmit);
}

Widget createProfileContainer(controllers, handleSubmit) {
  return _ProfileFormContainer(
      controllers: controllers, handleSubmit: handleSubmit);
}

final profileFormContainer = FormContainer(
    controllers: profileFormConfig, createChild: createProfileContainer);
