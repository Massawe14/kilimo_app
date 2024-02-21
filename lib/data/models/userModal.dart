// ignore_for_file: file_names

import '../../util/constants/enums.dart';

class UserModal {
  final String name;
  final String email;
  final String phone;
  late final UserType type;
  final String password;
  final String confirmPassword;

  UserModal({
    required this.name,
    required this.phone,
    required this.email,
    required this.type,
    required this.password,
    required this.confirmPassword,
  });
}
