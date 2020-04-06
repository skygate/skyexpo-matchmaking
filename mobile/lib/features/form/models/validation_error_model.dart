import 'package:meta/meta.dart';

typedef ValidationError AppValidator(dynamic value);

class ValidationError {
  final String key;
  final dynamic value;

  ValidationError({@required this.key, @required this.value});
}
