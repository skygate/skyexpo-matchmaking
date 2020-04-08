import 'package:union/union.dart';

import '../models/controller_value_union.dart' show FieldValueUnion;
import '../models/validation_error_model.dart' show ValidationError;

// 8 characters, one small letter, big letter, number and special character
final passwordRegex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

ValidationError isValidPasswordValidator(FieldValueUnion value) {
  String text = value.value;

  bool isValidPassword = passwordRegex.hasMatch(text);

  return isValidPassword == false
      ? ValidationError(
          key: 'incorrectPassword', value: 'The password is incorrect')
      : null;
}
