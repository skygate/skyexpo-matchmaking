import 'package:flutter/material.dart';

import '../models/controller_value_union.dart' show FieldValueUnion;
import '../models/form_field_controller_model.dart' show FormFieldController;
import '../models/on_form_submit_type.dart' show OnFormSubmit;

class FormContainer extends StatefulWidget {
  final Map<String, FormFieldController> controllers;
  final Widget Function(Map<String, FormFieldController>, OnFormSubmit)
      createChild;

  FormContainer({@required this.controllers, @required this.createChild});

  @override
  _FormContainerState createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  Map<String, FormFieldController> controllers;
  bool hasErrors = false;
  _FormContainerState();

  @override
  void initState() {
    super.initState();
    controllers = widget.controllers;
  }

  @override
  void dispose() {
    this.disposeAllControllers();

    super.dispose();
  }

  void checkIfFieldsHaveErrors() {
    this.hasErrors = this
        .controllers
        .values
        .any((controller) => controller.errors.isNotEmpty);
  }

  void disposeAllControllers() => this
      .controllers
      .values
      .map((controller) => controller.onDispose())
      .toList();

  void validateAllFormFields() => this
      .controllers
      .values
      .map((controller) => controller.validateField())
      .toList();

  void markAllFieldsAsTouched() => this
      .controllers
      .values
      .map((controller) => controller.setFieldAsTouched())
      .toList();

  Map<String, FieldValueUnion> getFormValues() {
    final listOfValues = this
        .controllers
        .entries
        .map((entry) => MapEntry(entry.key, entry.value.valueSubject.value));

    return Map.fromIterable(
      listOfValues,
      key: (controller) => controller.key,
      value: (controller) => controller.value,
    );
  }

  Map<String, FieldValueUnion> handleSubmit() {
    setState(() {
      this.markAllFieldsAsTouched();
      this.validateAllFormFields();
      this.checkIfFieldsHaveErrors();
    });

    if (!this.hasErrors) {
      final values = this.getFormValues();

      return values;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) =>
      widget.createChild(controllers, handleSubmit);
}
