class Validators {
  static bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  static bool isValidPhone(String phone) {
    String pattern =
        r'^[0-9]{10}$'; // Example pattern for a 10-digit phone number
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(phone);
  }
}
