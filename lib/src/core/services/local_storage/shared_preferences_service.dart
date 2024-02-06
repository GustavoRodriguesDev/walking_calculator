import 'package:shared_preferences/shared_preferences.dart';

import '../../error/local_storage_error.dart';
import 'i_local_storage.dart';

class SharedPreferencesService implements IlocalStorage {
  late SharedPreferences prefs;

  SharedPreferencesService() {
    init();
  }
  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> writeStringList(String key, List<String> itens) async {
    try {
      final result = await prefs.setStringList(key, itens);
      if (result) {
        return;
      }
    } catch (e, s) {
      throw LocalStorageWriteError(
        message: e.toString(),
        stackTrace: s,
      );
    }
  }

  @override
  List<String> readStringList(String key) {
    try {
      final result = prefs.getStringList(key);

      return result ?? [];
    } catch (e, s) {
      throw LocalStorageReadError(
        message: e.toString(),
        stackTrace: s,
      );
    }
  }
}
