import 'package:flutter/material.dart';

import 'package:mobile/features/form/models/form_field_controller_model.dart'
    show FormFieldController;
import 'package:mobile/features/form/widgets/form_text_field_widget.dart'
    show FormTextField;
import 'image_picker_widget.dart' show ImagePicker;

class ProfileFormFields extends StatelessWidget {
  final Map<String, FormFieldController> controllers;

  ProfileFormFields({@required this.controllers});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormTextField(
            label: "Avatar",
            controller: controllers["avatar"],
          ),
          // ImagePicker(),
          FormTextField(
            label: "Phone (optional)",
            controller: controllers["phone"],
          ),
          FormTextField(
            label: "Country",
            controller: controllers["country"],
          ),
          FormTextField(
            label: "Proffesion",
            controller: controllers["proffesion"],
          ),
          FormTextField(
            label: "Role",
            controller: controllers["role"],
          ),
          FormTextField(
            label: "Gender",
            controller: controllers["gender"],
          ),
          FormTextField(
            label: "Short biogram (optional)",
            controller: controllers["biogram"],
          ),
        ],
      );
}
