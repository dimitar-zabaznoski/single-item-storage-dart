import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_item_shared_prefs/single_item_shared_prefs.dart';
import 'package:single_item_storage/storage.dart';

Type _typeOf<T>() => T;

/// [Storage] implementation that uses [SharedPreferences]
/// to store primitive items that don't need a converter.
///
/// Supported types: `bool`, `double`, `int`, `String`, `List<String>`.
class PrimitivePrefsStorage<E> extends SharedPrefsStorage<E> {
  PrimitivePrefsStorage(String itemKey, [SharedPreferences? sharedPrefs])
      : assert(E == bool ||
            E == double ||
            E == int ||
            E == String ||
            E == _typeOf<List<String>>()),
        super.base(itemKey, sharedPrefs);

  @override
  Future<E> save(E item) async {
    await ensurePreferencesSet();
    if (item is bool) {
      await sharedPreferences!.setBool(itemKey, item);
    } else if (item is double) {
      await sharedPreferences!.setDouble(itemKey, item);
    } else if (item is int) {
      await sharedPreferences!.setInt(itemKey, item);
    } else if (item is String) {
      await sharedPreferences!.setString(itemKey, item);
    } else if (item is List<String>) {
      await sharedPreferences!.setStringList(itemKey, item);
    } else {
      throw ArgumentError('Item of unsupported type: ${E.runtimeType}');
    }
    return item;
  }

  @override
  Future<E?> get() async {
    await ensurePreferencesSet();

    dynamic item = sharedPreferences!.get(itemKey);
    if (item is List) {
      item = (item as List<Object?>?)?.cast<String>().toList();
    }
    return item as E?;
  }
}
