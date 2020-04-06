import 'package:mobile/common/models/validation_error_model.dart';

ValidationError isNotEmptyValidator(dynamic value) => value.isEmpty
    ? ValidationError(key: 'required', value: 'This field is required')
    : null;
