import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _tokenKey = "token";
  static const String _vendorId = 'vendorId';
  static const String _vendorName = 'vendorName';
  static const String _vendorType = 'vendorType';
  static const String _deviceToken = 'deviceToken';
  static const String _userId = 'userId';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userId, userId);
  }

  static Future<void> saveDeviceToken(String deviceToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_deviceToken, deviceToken);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userId);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<String?> getDeviceToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_deviceToken);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<void> clearDeviceToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_deviceToken);
  }

  static Future<void> saveVendorId(int vendorId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_vendorId, vendorId);
  }

  static Future<int?> getVendorId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_vendorId);
  }

  static Future<void> clearVendorId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_vendorId);
  }

  static Future<void> saveVendorName(String vendorName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_vendorName, vendorName);
  }

  static Future<String?> getVendorName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_vendorName);
  }

  static Future<void> clearVendorName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_vendorName);
  }

  static Future<void> saveVendorType(String vendorType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_vendorType, vendorType);
  }

  static Future<String?> getVendorType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_vendorType);
  }

  static Future<void> clearVendorType() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_vendorType);
  }
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);

    return token != null && token.isNotEmpty;
  }

}
