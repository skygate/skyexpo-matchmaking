import 'package:flutter/material.dart';
// import 'package:mobile/common/models/form_field_controller_model.dart';

import 'package:mobile/common/validators/validators.dart'
    show isNotEmptyValidator;

import 'package:mobile/features/form/models/form_field_controller_model.dart';
import 'package:mobile/features/form/widgets/form_text_field_widget.dart';
import 'image_picker_widget.dart' show ImagePicker;

class ProfileFormFields extends StatelessWidget {
  final Map<String, FormFieldController> controllers;

  ProfileFormFields({@required this.controllers});

  @override
  Widget build(BuildContext context) {
    // print(profileFormGroup.);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormTextField(
          label: "Avatar",
          validators: [isNotEmptyValidator],
          controller: controllers["avatar"],
        ),
        // ImagePicker(),
        // FormTextField(
        //   fieldId: 'phone',
        //   label: "Phone (optional)",
        //   setFormFieldValue: setFormFieldValue,
        //   formValues: formData,
        //   validators: [isNotEmptyValidator],
        // ),
        // FormTextField(
        //   fieldId: 'country',
        //   label: "Country",
        //   setFormFieldValue: setFormFieldValue,
        //   formValues: formData,
        //   validators: [isNotEmptyValidator],
        // ),
        // FormTextField(
        //   fieldId: 'proffesion',
        //   label: "Proffesion",
        //   setFormFieldValue: setFormFieldValue,
        //   formValues: formData,
        //   validators: [isNotEmptyValidator, isValidEmailValidator],
        // ),
        // FormTextField(
        //   fieldId: 'Role ',
        //   label: "Role",
        //   setFormFieldValue: setFormFieldValue,
        //   formValues: formData,
        //   validators: [isNotEmptyValidator],
        // ),
        // FormTextField(
        //   fieldId: 'gender',
        //   label: "Gender",
        //   setFormFieldValue: setFormFieldValue,
        //   formValues: formData,
        //   validators: [isNotEmptyValidator, isValidEmailValidator],
        // ),
        // FormTextField(
        //   fieldId: 'biogram',
        //   label: "Short biogram (optional)",
        //   setFormFieldValue: setFormFieldValue,
        //   formValues: formData,
        // ),
      ],
    );
  }
}
