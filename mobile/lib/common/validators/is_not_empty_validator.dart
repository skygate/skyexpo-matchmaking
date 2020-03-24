String isNotEmptyValidator(String value) {
  return value.isEmpty ? 'This field is required' : null;
}
