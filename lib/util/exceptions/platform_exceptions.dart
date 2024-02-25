// Exception class for handling various platform-related errors
class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return "Invalid login credentials. Please double-check your information.";
      default:
        return "An unexpected Platform error occurred. Please try again.";
    }
  }
}