import 'package:get_storage/get_storage.dart';

class StoragePrefs {
  static final storage = GetStorage();

  static void setStorageValue(String key, dynamic value) async {
    await storage.write(key, value);
  }

  static void writeIfNullValue(String key, dynamic value) async {
    await storage.writeIfNull(key, value);
  }

  static dynamic getStorageValue(String key) {
    return storage.read(key);
  }

  static void removeStorageValue(String key) async {
    return await storage.remove(key);
  }

  static void clearAll() {
    storage.erase();
  }
}
