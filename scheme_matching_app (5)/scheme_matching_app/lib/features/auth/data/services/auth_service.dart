import '../models/user_model.dart';

/// Phase 1 accepts any non-empty credentials so the navigation flow can
/// be built and demoed before the backend exists. Phase 3 swaps the body
/// of these two methods for real POST /auth/login and /auth/register
/// calls plus JWT storage - the method signatures stay the same.
class AuthService {
  Future<UserModel> login(String identifier, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (identifier.isEmpty || password.isEmpty) {
      throw Exception('Please enter your details to continue.');
    }
    return UserModel(id: 'user_local_1', name: 'Entrepreneur', phoneOrEmail: identifier);
  }

  Future<UserModel> register(String name, String identifier, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (name.isEmpty || identifier.isEmpty || password.isEmpty) {
      throw Exception('Please fill in all fields to continue.');
    }
    return UserModel(id: 'user_local_1', name: name, phoneOrEmail: identifier);
  }

  Future<UserModel?> continueAsGuest() async {
    return const UserModel(id: 'guest', name: 'Guest', phoneOrEmail: '');
  }
}
