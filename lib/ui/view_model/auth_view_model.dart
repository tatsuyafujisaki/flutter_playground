import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repository/auth_repository.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  UserCredential? build() => null;

  Future<void> signInAnonymously() async {
    final authRepository = ref.read(authRepositoryProvider);
    if (authRepository.currentUser == null) {
      state = await authRepository.signInAnonymously();
    }
  }
}
