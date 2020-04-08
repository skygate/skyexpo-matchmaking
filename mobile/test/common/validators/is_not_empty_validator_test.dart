import 'package:union/union.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile/features/form/models/controller_value_union.dart'
    show FieldValueUnion;
import 'package:mobile/features/form/validators/index.dart'
    show isNotEmptyValidator;

void main() {
  group('isNotEmptyValidator', () {
    test('should return validation error', () {
      final FieldValueUnion value = ''.asFirst();
      final result = isNotEmptyValidator(value);

      expect(result, 'This field is required');
    });

    test('should return validation null on success validation', () {
      final FieldValueUnion value = 'some string'.asFirst();

      final result = isNotEmptyValidator(value);

      expect(result, null);
    });
  });
}
