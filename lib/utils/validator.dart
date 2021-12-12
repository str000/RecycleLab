class Validator {
  static String? validateName({String? name}) {
    if (name == null) {
      return '';
    }

    if (name.isEmpty) {
      return '';
    }

    return null;
  }

  static String? validateDate({required String? date}) {
    if (date == null) {
      return '';
    }

    if (date.isEmpty) {
      return '';
    }

    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return '';
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return '';
    } else if (!emailRegExp.hasMatch(email)) {
      return '';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return '';
    }

    if (password.isEmpty) {
      return '';
    } else if (password.length < 6) {
      return '';
    }

    return null;
  }

  static String? validateRePassword(
      {required String? repassword, String? password}) {
    if (repassword == null) {
      return '';
    }

    if (repassword.isEmpty) {
      return '';
    } else if (repassword.length < 6) {
      return '';
    }

    if (repassword != password) {
      return '';
    }

    return null;
  }
}
