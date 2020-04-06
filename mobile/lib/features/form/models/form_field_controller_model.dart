import 'package:mobile/features/form/models/validation_error_model.dart';

import 'on_form_submit_type.dart';

class FormFieldController {
  final String key;
  final List<AppValidator> validators;
  dynamic value;
  Map<String, String> errors = {};
  bool touched = false;

  FormFieldController({this.key, this.value, this.validators});

  handleChange(dynamic newValue) {
    value = newValue;
    this.validateField();
  }

  handleBlur() {
    setFieldAsTouched();
  }

  setFieldAsTouched() {
    this.touched = true;
  }

  validateField() {
    final errorsList = validators
        .map((validator) => validator(value))
        .where((error) => error != null);

    errors = Map.fromIterable(
      errorsList,
      key: (controller) => controller.key,
      value: (controller) => controller.value,
    );
  }
}

class FormGroup {
  Map<String, FormFieldController> controllers;
  bool hasErrors = false;
  bool isSubmitted = false;

  FormGroup(
    this.controllers,
  );

  void validateFields() => this
      .controllers
      .values
      .map((controller) => controller.validateField())
      .toList();

  void checkIfFieldsHaveErrors() {
    this.hasErrors = this
        .controllers
        .values
        .any((controller) => controller.errors.isNotEmpty);
  }

  void markAllFieldsAsTouched() {
    final newControllersList = this.controllers.entries.map((entry) {
      entry.value.touched = true;
      return entry;
    });

    this.controllers = Map.fromIterable(
      newControllersList,
      key: (controller) => controller.key,
      value: (controller) => controller.value,
    );
  }

  Map<String, String> getFormValues() {
    final listOfValues = this.controllers.entries.map((entry) {
      return MapEntry(entry.key, entry.value.value);
    });

    return Map.fromIterable(
      listOfValues,
      key: (controller) => controller.key,
      value: (controller) => controller.value,
    );
  }

  handleSubmit(OnFormSubmit onSubmit) {
    this.markAllFieldsAsTouched();
    this.validateFields();
    this.checkIfFieldsHaveErrors();

    if (!this.hasErrors) {
      final values = this.getFormValues();
      onSubmit(values);
    }
  }
}
