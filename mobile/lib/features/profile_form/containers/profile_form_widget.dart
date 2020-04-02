import 'package:flutter/material.dart';
import 'package:mobile/features/profile_form/widgets/profile_form_widget.dart';

class ProfileFormContainer extends StatefulWidget {
  @override
  _ProfileFormContainerState createState() => _ProfileFormContainerState();
}

class _ProfileFormContainerState extends State<ProfileFormContainer> {
  final formKey = GlobalKey<FormState>();
  Map<String, String> profileFormData;

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
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) => ProfileForm(
        formKey: formKey,
        profileFormData: profileFormData,
        setFormFieldValue: setFormFieldValue,
        onFormSubmit: submitForm,
      );
}
