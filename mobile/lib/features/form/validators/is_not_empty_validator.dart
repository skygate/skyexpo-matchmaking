import 'package:union/union.dart';

import '../models/controller_value_union.dart' show FieldValueUnion;
import '../models/validation_error_model.dart' show ValidationError;

ValidationError isNotEmptyValidator(FieldValueUnion value) {
  String text = value.value;

  return text.isEmpty
      ? ValidationError(key: 'required', value: 'This field is required')
      : null;
}
