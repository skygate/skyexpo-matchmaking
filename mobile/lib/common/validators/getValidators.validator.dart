composeValidators(Iterable validators, String value) {
  final validator = validators.firstWhere(
      (validator) => validator(value).runtimeType == String,
      orElse: () => null);

  return validator == null ? null : validator(value);
}
