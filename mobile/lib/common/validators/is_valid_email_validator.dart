String isValidEmailValidator(String value) {
  bool isValidEmail = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);

  if (isValidEmail == false) {
    return 'The email is incorrect';
  }

  return null;
}
