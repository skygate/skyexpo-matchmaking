import 'package:union/union.dart';

import '../models/controller_value_union.dart' show FieldValueUnion;
import '../models/validation_error_model.dart' show ValidationError;

ValidationError isValidEmailValidator(FieldValueUnion value) {
  String text = value.value;

  bool isValidEmail = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(text);

  return isValidEmail == false
      ? ValidationError(key: 'incorrectEmail', value: 'The email is incorrect')
      : null;
}
