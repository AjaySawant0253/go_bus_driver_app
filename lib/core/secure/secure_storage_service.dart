import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  Future<void> saveFcmToken(String token) async {
    await _storage.write(key: 'fcmToken', value: token);
  }

  Future<String?> getFcmToken() async {
    return await _storage.read(key: 'fcmToken');
  }

  // Future<void> saveUserData(UserModel user) async {
  //   final jsonString = jsonEncode(user.toJson());
  //   await _storage.write(key: 'user_data', value: jsonString);
  // }

  // Future<UserModel?> getUserData() async {
  //   final jsonString = await _storage.read(key: 'user_data');
  //   if (jsonString == null) return null;
  //   final Map<String, dynamic> json = jsonDecode(jsonString);
  //   return UserModel.fromJson(json);
  // }

  Future<void> saveHasMpin(bool hasMpin) async {
    await _storage.write(key: 'has_mpin', value: hasMpin.toString());
  }

  Future<bool> getHasMpin() async {
    final value = await _storage.read(key: 'has_mpin');
    return value == 'true';
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
