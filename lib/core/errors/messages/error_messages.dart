class ErrorMessages {
  ErrorMessages._();
  static String errorMessage(String? error) {
    if (error != null) {
      //* Ex of error messages we get from the server.
      if (error == 'Invalid credentials') {
        return 'Wrong username or password';
      }
    }
    if (error == null || error.isEmpty) {
      return 'Something went wrong';
    } else {
      return 'Something went wrong';
    }
  }
}
