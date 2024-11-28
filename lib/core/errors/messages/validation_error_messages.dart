class ValidationErrorTexts {
  ValidationErrorTexts._();
  //* Ex of validations messages.
  static String? emailValidation(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email';
    }
    if (email.length < 5 ||
        !RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,}$')
            .hasMatch(email)) {
      return 'Please enter a valid email';
    }

    if (email.contains(' ')) {
      return 'Do not use space';
    }
    return null;
  }
}
