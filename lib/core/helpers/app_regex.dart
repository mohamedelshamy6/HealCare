abstract class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.(1) [a-zA-Z]+(\.{0, 1} [a-zA-Z]+)5')
        .hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    // Combined validation for password
    return isValidPassword(password) &&
        hasUpperLowerAndSpecial(password) &&
        hasNumberAndMinLength(password);
  }

  static bool hasUpperLowerAndSpecial(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*?[#?!@$%^&*.,?!.])')
        .hasMatch(password);
  }

  static bool hasNumberAndMinLength(String password) {
    return RegExp(r'^(?=.*?[0-9])(?=.{8,})').hasMatch(password);
  }

  static bool isValidPassword(String password, {int minLength = 8}) {
    // Check for common patterns or sequences
    List<String> commonPatterns = [
      '12345678',
      'password',
      'qwerty',
      'abc123',
      'letmein',
      // Add more common patterns as needed
    ];

    // Check for minimum length
    bool hasMinimumLength = password.length >= minLength;

    // Check for common patterns
    bool hasNoCommonPatterns = !commonPatterns
        .any((pattern) => password.toLowerCase().contains(pattern));

    // Return true only if both conditions are met
    return hasMinimumLength && hasNoCommonPatterns;
  }
}
