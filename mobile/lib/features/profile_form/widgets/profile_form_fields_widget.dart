import 'package:flutter/material.dart';

import 'package:mobile/common/validators/index.dart'
    show isNotEmptyValidator, isValidEmailValidator;
import 'package:mobile/common/widgets/form_text_field_widget.dart'
    show FormTextField;

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
        children: <Widget>[
          FormTextField(
            fieldId: 'name',
            label: "Name",
            setFormFieldValue: setFormFieldValue,
            formValues: formData,
            validators: [isNotEmptyValidator],
          ),
          FormTextField(
            fieldId: 'email',
            label: "Email address",
            setFormFieldValue: setFormFieldValue,
            formValues: formData,
            validators: [isNotEmptyValidator, isValidEmailValidator],
          ),
        ],
      ),
    );
  }
}
