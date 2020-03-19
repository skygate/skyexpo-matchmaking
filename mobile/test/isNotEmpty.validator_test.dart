import 'package:flutter_test/flutter_test.dart';

import 'package:mobile/common/validators/isNotEmpty.validator.dart';

void main() {
  group('isNotEmptyValidator', () {
    test('should return validation error', () {
      final result = isNotEmptyValidator('');

      expect(result, 'This field is required');
    });

    test('should return validation null on success validation', () {
      final result = isNotEmptyValidator('some string');

      expect(result, null);
    });
  });
}
