import 'package:mobile/common/models/validation_error_model.dart';

ValidationError isNotEmptyValidator(String value) {
  return value.isEmpty
      ? ValidationError(key: 'required', value: 'This field is required')
      : null;
}
