import 'package:rxdart/rxdart.dart';

import '../models/controller_value_union.dart' show FieldValueUnion;
import '../models/validation_error_model.dart' show AppValidator;

class FormFieldController {
  final List<AppValidator> validators;
  Map<String, String> errors = {};
  BehaviorSubject<FieldValueUnion> valueSubject =
      BehaviorSubject<FieldValueUnion>();
  BehaviorSubject<bool> touchedSubject = BehaviorSubject<bool>();

  FormFieldController({
    FieldValueUnion initialValue,
    this.validators,
  }) {
    this.valueSubject.add(initialValue);
    this.touchedSubject.add(false);
  }

  void onDispose() {
    this.valueSubject.close();
    this.touchedSubject.close();
  }

  void handleChange(FieldValueUnion newValue) {
    this.valueSubject.add(newValue);
    this.validateField();
  }

  void handleBlur() {
    this.setFieldAsTouched();
    this.validateField();
  }

  void setFieldAsTouched() {
    this.touchedSubject.add(true);
  }

  void validateField() {
    final errorsList = validators
        .map((validator) => validator(this.valueSubject.value))
        .where((error) => error != null);

    this.errors = Map.fromIterable(
      errorsList,
      key: (controller) => controller.key,
      value: (controller) => controller.value,
    );
  }
}
