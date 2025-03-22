class ErrorMessages {
  ErrorMessages._();
  static String errorMessage(String? error) {
    if (error != null) {
      //* Ex of error messages we get from the server.
      if (error == 'Invalid login credentials') {
        return 'Wrong username or password';
      } else if (error == 'User not found') {
        return 'User not found';
      } else if (error == 'User already registered') {
        return 'User already exists';
      } else if (error == 'Request Entity Too Large') {
        return 'Request Entity Too Large';
      } else if (error == 'Invalid OTP') {
        return 'Invalid OTP';
      } else if (error == 'Unable to validate email address: invalid format') {
        return 'Invalid email';
      } else if (error == 'Invalid password') {
        return 'Invalid password';
      }
    }
    if (error == null || error.isEmpty) {
      return 'Something went wrong, please try again later';
    } else {
      return 'Something went wrong, please try again later';
    }
  }
}
