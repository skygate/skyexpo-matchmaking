import 'package:rxdart/rxdart.dart';

import '../models/validation_error_model.dart';

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

  void onDispose() {
    this.valueSubject.close();
    this.touchedSubject.close();
  }

  void handleChange(newValue) {
    this.valueSubject.add(newValue);
    this.validateField();
  }

  void handleBlur() {
    setFieldAsTouched();
    validateField();
  }

  void setFieldAsTouched() {
    this.touchedSubject.add(true);
  }

  void validateField() {
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
