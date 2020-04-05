import 'package:mobile/common/models/validation_error_model.dart';

import 'on_form_submit_type.dart';

class FormFieldController {
  final String key;
  final List<AppValidator> validators;
  dynamic value;
  Map<String, String> errors;
  bool touched;

  FormFieldController({this.key, this.touched, this.validators});

  handleChange(dynamic newValue) {
    value = newValue;
    this.handleFieldValidation(newValue);
  }

  handleBlur() {
    setFieldAsTouched();
  }

  setFieldAsTouched() {
    this.touched = true;
  }

  handleFieldValidation(newValue) {
    final errorsList = validators.map((validator) => validator(newValue));
    errors = Map.fromIterable(errorsList);
  }
}

class FormGroup {
  final Map<String, FormFieldController> controllers;
  bool hasErrors;
  bool isSubmitted;

  FormGroup(
    this.controllers,
  );

  void checkIfFieldsHaveErrors() {
    this.hasErrors = this
        .controllers
        .entries
        .any((controller) => controller.value.errors.isNotEmpty);
  }

  void markAllFieldsAsTouched() {
    this
        .controllers
        .entries
        .map((controller) => controller.value.touched = true);
  }

  Map<String, String> getFormValues() {
    final listOfValues =
        this.controllers.entries.map((entry) => {entry.key, entry.value.value});
    return Map.fromIterable(listOfValues);
  }

  handleSubmit(OnFormSubmit onSubmit) {
    this.markAllFieldsAsTouched();
    this.checkIfFieldsHaveErrors();

    if (!this.hasErrors) {
      final values = this.getFormValues();
      onSubmit(values);
    }
  }
}
