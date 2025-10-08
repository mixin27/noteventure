import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStorage {
  static const String _userDataKey = 'user_data';

  final FlutterSecureStorage _storage;

  UserStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  // Save user data
  Future<void> saveUser({
    required String id,
    required String email,
    String? username,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool isActive,
  }) async {
    final userData = {
      'id': id,
      'email': email,
      'username': username,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
    };

    await _storage.write(key: _userDataKey, value: json.encode(userData));
  }

  // Get user data
  Future<Map<String, dynamic>?> getUser() async {
    final userDataString = await _storage.read(key: _userDataKey);

    if (userDataString == null) {
      return null;
    }

    try {
      return json.decode(userDataString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // Clear user data
  Future<void> clearUser() async {
    await _storage.delete(key: _userDataKey);
  }
}
