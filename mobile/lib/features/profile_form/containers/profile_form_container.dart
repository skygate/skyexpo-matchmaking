import 'package:flutter/material.dart';
// import 'package:mobile/common/models/form_field_controller_model.dart';
import 'package:mobile/features/form/containers/form_container.dart';
import 'package:mobile/features/profile_form/configs/profile_form_config.dart';
import 'package:mobile/features/profile_form/mocks/team_avatars_mock.dart';
import 'package:mobile/features/profile_form/widgets/profile_form_widget.dart';

class ProfileFormContainer extends FormContainer {
  ProfileFormContainer()
      : super(
            controllers: profileFormConfig,
            child: ProfileForm(
                onFormSubmit: () => {},
                team: teamMock,
                controllers: profileFormConfig));

  void onSubmit() {
    print(this.controllers['avatar'].key);
  }
}
