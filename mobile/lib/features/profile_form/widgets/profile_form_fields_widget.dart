import 'package:flutter/material.dart';

import 'package:mobile/common/validators/index.dart'
    show isNotEmptyValidator, isValidEmailValidator;
import 'package:mobile/common/widgets/form_text_field_widget.dart'
    show FormTextField;
import 'image_picker_widget.dart' show ImagePicker;

class ProfileFormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function setFormFieldValue;
  final Map<String, String> formData;

  ProfileFormFields({
    @required this.setFormFieldValue,
    @required this.formKey,
    @required this.formData,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormTextField(
            fieldId: 'name',
            label: "Name",
            setFormFieldValue: setFormFieldValue,
            formValues: formData,
            validators: [isNotEmptyValidator],
          ),
          ImagePicker(),
          FormTextField(
            fieldId: 'phone',
            label: "Phone (optional)",
            setFormFieldValue: setFormFieldValue,
            formValues: formData,
            validators: [isNotEmptyValidator],
          ),
          FormTextField(
            fieldId: 'country',
            label: "Country",
            setFormFieldValue: setFormFieldValue,
            formValues: formData,
            validators: [isNotEmptyValidator],
          ),
          FormTextField(
            fieldId: 'proffesion',
            label: "Proffesion",
            setFormFieldValue: setFormFieldValue,
            formValues: formData,
            validators: [isNotEmptyValidator, isValidEmailValidator],
          ),
          FormTextField(
            fieldId: 'Role ',
            label: "Role",
            setFormFieldValue: setFormFieldValue,
            formValues: formData,
            validators: [isNotEmptyValidator],
          ),
          FormTextField(
            fieldId: 'gender',
            label: "Gender",
            setFormFieldValue: setFormFieldValue,
            formValues: formData,
            validators: [isNotEmptyValidator, isValidEmailValidator],
          ),
          FormTextField(
            fieldId: 'biogram',
            label: "Short biogram (optional)",
            setFormFieldValue: setFormFieldValue,
            formValues: formData,
          ),
        ],
      ),
    );
  }
}
