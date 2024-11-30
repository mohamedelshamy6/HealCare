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

  static String? otpValidation(
    String? field,
  ) {
    if (field == null || field.isEmpty) {
      return 'Please enter OTP';
    }
    if (field.length < 4) {
      return 'OTP must be 4 digits';
    }
    return null;
  }

  static String? nameValidation(String? name) {
    if (name == null || name.isEmpty || name.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (name.contains(RegExp(r'[^\w\s]+')) || name.contains('_')) {
      return 'Please enter a valid name';
    }
    if (name.contains(' ')) {
      return 'Please do not use space';
    }
    if (!name.contains(RegExp(r'\D+'))) {
      return 'Please do not use numbers';
    }
    if (name.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  static String? signUpPasswordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!password.contains(RegExp(r'[!@#$%^&*\-+=_(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (password.contains(' ')) {
      return 'Please do not use space';
    }
    return null;
  }

  static String? loginPasswordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (password.contains(' ')) {
      return 'Please do not use space';
    }
    return null;
  }

  static String? confirmPasswordValidation(
    String? passwordConfirmation,
    String? password,
  ) {
    if (passwordConfirmation == null || passwordConfirmation.isEmpty) {
      return 'Please confirm your password';
    }
    if (password != passwordConfirmation) {
      return 'Passwords do not match';
    }
    if (passwordConfirmation.contains(' ')) {
      return 'Please do not use space';
    }
    return null;
  }
}
