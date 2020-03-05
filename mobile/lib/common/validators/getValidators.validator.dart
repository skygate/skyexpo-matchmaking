composeValidators(Iterable validators, String value) {
  var validator = validators.firstWhere(
      (validator) => validator(value).runtimeType == String,
      orElse: () => null);

  if (validator == null) {
    return null;
  }
  return validator(value);
}
