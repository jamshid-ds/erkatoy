import 'package:hive/hive.dart';

class HiveLocalStorage {
  Box _getBox(String name) => Hive.box(name);

  Future<void> saveBool({required String boxName, required String key, required bool value}) =>
      _getBox(boxName).put(key, value);

  Future<bool> getBool({required String boxName, required String key}) async {
    final bool? value = await _getBox(boxName).get(key);
    return value ?? false;
  }

  Future<void> deleteBool({required String boxName, required String key}) =>
      _getBox(boxName).delete(key);

  Future<void> saveString({required String boxName, required String key, required String value}) =>
      _getBox(boxName).put(key, value);

  Future<String?> getString({required String boxName, required String key}) async {
    final String? value = await _getBox(boxName).get(key);
    return value;
  }

  Future<void> deleteString({required String boxName, required String key}) =>
      _getBox(boxName).delete(key);

  Future<void> saveInt({required String boxName, required String key, required int value}) =>
      _getBox(boxName).put(key, value);

  Future<int?> getInt({required String boxName, required String key}) async {
    final int? value = await _getBox(boxName).get(key);
    return value;
  }

  Future<void> deleteInt({required String boxName, required String key}) =>
      _getBox(boxName).delete(key);
}
