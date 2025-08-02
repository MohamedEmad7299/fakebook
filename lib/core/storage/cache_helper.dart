import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  final SharedPreferences _prefs;

  CacheHelper._(this._prefs);

  static Future<CacheHelper> create() async {
    final prefs = await SharedPreferences.getInstance();
    return CacheHelper._(prefs);
  }

  // ✅ Generic getter with type safety
  T? get<T>(String key) {
    final value = _prefs.get(key);
    if (value is T) return value;
    return null;
  }

  // ✅ Generic setter with type safety
  Future<bool> set<T>(String key, T value) async {
    if (value is String) return _prefs.setString(key, value);
    if (value is int) return _prefs.setInt(key, value);
    if (value is bool) return _prefs.setBool(key, value);
    if (value is double) return _prefs.setDouble(key, value);
    throw ArgumentError('Unsupported type');
  }

  // ✅ Remove a key
  Future<bool> remove(String key) => _prefs.remove(key);

  // ✅ Clear all cached data
  Future<bool> clear() => _prefs.clear();
}
