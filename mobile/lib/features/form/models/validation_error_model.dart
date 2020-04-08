import 'package:meta/meta.dart';

import 'controller_value_union.dart';

typedef ValidationError AppValidator(FieldValueUnion value);

class ValidationError {
  final String key;
  final String value;

  ValidationError({@required this.key, @required this.value});
}
