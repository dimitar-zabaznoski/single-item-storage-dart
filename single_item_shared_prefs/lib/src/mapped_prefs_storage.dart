import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_item_shared_prefs/single_item_shared_prefs.dart';
import 'package:single_item_storage/storage.dart';

/// [Storage] implementation that uses [SharedPreferences] and dart JSON
/// converters to store items.
class MappedPrefsStorage<E> extends SharedPrefsStorage<E> {
  @protected
  final ToMap<E> toMap;
  @protected
  final FromMap<E> fromMap;

  /// Makes a new instance using the provided [fromMap] and [toMap] item
  /// converters, [itemKey] as key in the [sharedPreferences] instance.
  MappedPrefsStorage(
    this.toMap,
    this.fromMap,
    String itemKey, [
    SharedPreferences? sharedPreferences,
  ]) : super.base(itemKey, sharedPreferences);

  @override
  Future<E> save(E item) async {
    await ensurePreferencesSet();
    await sharedPreferences!.setString(itemKey, jsonEncode(toMap(item)));
    return item;
  }

  @override
  Future<E?> get() async {
    await ensurePreferencesSet();
    final itemJson = sharedPreferences!.getString(itemKey);
    return itemJson == null ? null : fromMap(json.decode(itemJson));
  }
}
