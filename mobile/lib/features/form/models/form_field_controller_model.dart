import 'package:mobile/features/form/models/validation_error_model.dart';
import 'package:rxdart/rxdart.dart';

import 'on_form_submit_type.dart';

class FormFieldController {
  final String key;
  final List<AppValidator> validators;
  BehaviorSubject<dynamic> valueSubject = BehaviorSubject();
  Map<String, String> errors = {};
  bool touched = false;

  FormFieldController({
    this.key,
    initialValue,
    this.validators,
  }) {
    this.valueSubject.add(initialValue);
  }

  handleChange(dynamic newValue) {
    this.valueSubject.add(newValue);
    this.validateField();
    print(this.errors);
  }

  handleBlur() {
    setFieldAsTouched();
  }

  setFieldAsTouched() {
    this.touched = true;
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
