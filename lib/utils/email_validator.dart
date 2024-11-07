class EmailValidator {
  static RegExp regex = RegExp(r'^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$');

  static bool validateEmail(String input) {
    return regex.hasMatch(input);
  }
}
