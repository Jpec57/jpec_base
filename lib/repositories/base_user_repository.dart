import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class BaseUserRepository {
  static const AUTHENTICATION_KEY = "AUTHENTICATION_KEY";

  /// Login method using username and password and return an API token.
  Future<String?> login({
    required String username,
    required String password,
    required String url,
  }) async {
    Dio dio = new Dio();
    HashMap hashMap = new HashMap();
    hashMap.putIfAbsent("username", () => username);
    hashMap.putIfAbsent("password", () => password);
    String? token;
    Response response = await dio.post(url, data: hashMap);
    HashMap<String, dynamic> data = response.data;
    token = data.containsKey("token") ? data['token'] : null;
    return token;
  }

  /// Delete user's token in secure storage (key "AUTHENTICATION_KEY")
  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: AUTHENTICATION_KEY);
    return;
  }

  /// Save user's token in secure storage with the key "AUTHENTICATION_KEY"
  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: AUTHENTICATION_KEY, value: token);
    return;
  }

  /// Check if user's token has a token stored with the key "AUTHENTICATION_KEY".
  Future<bool> hasToken() async {
    /// read from keystore/keychain
    FlutterSecureStorage storage = FlutterSecureStorage();
    String? token = await storage.read(key: AUTHENTICATION_KEY);
    return token != null;
  }
}
