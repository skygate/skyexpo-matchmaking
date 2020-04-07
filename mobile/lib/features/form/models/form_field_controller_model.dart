import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:mobile/features/form/models/validation_error_model.dart';
import 'on_form_submit_type.dart';

class FormFieldController {
  final List<AppValidator> validators;
  Map<String, String> errors = {};
  BehaviorSubject<dynamic> valueSubject = BehaviorSubject<dynamic>();
  BehaviorSubject<bool> touchedSubject = BehaviorSubject<bool>();

  FormFieldController({
    initialValue,
    this.validators,
  }) {
    this.valueSubject.add(initialValue);
    this.touchedSubject.add(false);
  }

  onDispose() {
    this.valueSubject.close();
    this.touchedSubject.close();
  }

  handleChange(newValue) {
    this.valueSubject.add(newValue);
    this.validateField();
    print(this.errors);
  }

  handleBlur() {
    setFieldAsTouched();
    validateField();
  }

  setFieldAsTouched() {
    this.touchedSubject.add(true);
  }

  validateField() {
    final errorsList = validators
        .map((validator) => validator(this.valueSubject.value))
        .where((error) => error != null);

    errors = Map.fromIterable(
      errorsList,
      key: (controller) => controller.key,
      value: (controller) => controller.value,
    );
  }
}
