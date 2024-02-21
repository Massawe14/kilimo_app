// ignore_for_file: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/userModal.dart';
import '../../data/services/user_service.dart';

final userProvider = StateNotifierProvider<UserService, UserModal>((ref) {
  return UserService(ref.read);
});
