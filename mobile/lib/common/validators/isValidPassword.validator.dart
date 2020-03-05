String isValidPasswordValidator(String value) {
  bool isValidPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(value);

  if (isValidPassword == false) {
    return null;
  }

  return null;
}
