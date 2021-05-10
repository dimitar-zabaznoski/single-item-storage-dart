import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_item_shared_prefs/single_item_shared_prefs.dart';
import 'package:single_item_shared_prefs/src/mapped_prefs_storage.dart';
import 'package:single_item_shared_prefs/src/primitive_prefs_storage.dart';
import 'package:single_item_storage/storage.dart';

/// [Storage] implementation that uses [SharedPreferences] to store items.
abstract class SharedPrefsStorage<E> implements Storage<E> {
  @protected
  final String itemKey;
  @protected
  SharedPreferences? sharedPreferences;

  /// Makes a new instance using the provided [fromMap] and [toMap] item
  /// converters, [itemKey] as key in the [sharedPreferences] instance.
  ///
  /// If the [sharedPreferences] param is omitted,
  /// then [SharedPreferences.getInstance] is used.
  factory SharedPrefsStorage({
    required ToMap<E> toMap,
    required FromMap<E> fromMap,
    required String itemKey,
    SharedPreferences? sharedPreferences,
  }) =>
      MappedPrefsStorage(toMap, fromMap, itemKey, sharedPreferences);

  /// [Storage] implementation that uses [SharedPreferences]
  /// to store primitive items that don't need a converter.
  ///
  /// Supported types: `bool`, `double`, `int`, `String`, `List<String>`.
  factory SharedPrefsStorage.primitive({
    required String itemKey,
    SharedPreferences? sharedPreferences,
  }) =>
      PrimitivePrefsStorage(itemKey, sharedPreferences);

  @protected
  SharedPrefsStorage.base(this.itemKey, [this.sharedPreferences]);

  @override
  Future<void> delete() async {
    await ensurePreferencesSet();
    await sharedPreferences!.remove(itemKey);
  }

  @protected
  Future<SharedPreferences> ensurePreferencesSet() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    return sharedPreferences!;
  }
}
