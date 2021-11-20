class Validator {
  static String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }

    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateDate({required String? date}) {
    if (date == null) {
      return null;
    }

    if (date.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return null; //Adres Email nie może być pusty
    } else if (!emailRegExp.hasMatch(email)) {
      return null; //Nie prawidłowy Adres Email
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return null; //Hasło nie może być puste
    } else if (password.length < 6) {
      return null; //Enter a password with length at least 6
    }

    return null;
  }

  static String? validateRePassword({required String? repassword}) {
    if (repassword == null) {
      return null;
    }

    if (repassword.isEmpty) {
      return null; //Hasło nie może być puste
    } else if (repassword.length < 6) {
      return null; //Enter a password with length at least 6
    }

    return null;
  }
}
