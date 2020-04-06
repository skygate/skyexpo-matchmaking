import 'package:flutter/material.dart';
import 'package:mobile/common/models/form_field_controller_model.dart';
import 'package:mobile/common/validators/validators.dart';
import 'package:mobile/features/profile_form/mocks/team_avatars_mock.dart';
import 'package:mobile/features/profile_form/widgets/profile_form_widget.dart';

class ProfileFormContainer extends StatefulWidget {
  @override
  _ProfileFormContainerState createState() => _ProfileFormContainerState();
}

class _ProfileFormContainerState extends State<ProfileFormContainer> {
  final formKey = GlobalKey<FormState>();
  Map<String, String> profileFormData;

  FormGroup profileFormGroup = FormGroup({
    "avatar": FormFieldController(
        key: "avatar", value: '', validators: [isNotEmptyValidator]),
    // "phone": FormFieldController(
    //     key: "phone", value: '', validators: [isNotEmptyValidator]),
    // "country": FormFieldController(
    //     key: "country", value: '', validators: [isNotEmptyValidator]),
    // "proffesion": FormFieldController(
    //     key: "proffesion", value: '', validators: [isNotEmptyValidator]),
    // "role": FormFieldController(
    //     key: "role", value: '', validators: [isNotEmptyValidator]),
    // "gender": FormFieldController(
    //     key: "gender", value: '', validators: [isNotEmptyValidator]),
  });

  @override
  void initState() {
    super.initState();
    profileFormData = {
      'avatar': '',
      'phone': '',
      'country': '',
      'proffesion': '',
      'role': '',
      'gender': ''
    };
  }

  void setFormFieldValue(String fieldId, String value) => setState(() {
        profileFormData[fieldId] = value;
      });

  void submitForm() {
    print('odpalam submit');

    profileFormGroup.handleSubmit((values) {
      print(values);
    });

    print(profileFormGroup.hasErrors);
    print(profileFormGroup.controllers['avatar'].touched);
    print(profileFormGroup.controllers['avatar'].errors);
  }

  @override
  Widget build(BuildContext context) => ProfileForm(
      formKey: formKey,
      profileFormData: profileFormData,
      setFormFieldValue: setFormFieldValue,
      onFormSubmit: submitForm,
      team: teamMock,
      profileFormGroup: profileFormGroup);
}
