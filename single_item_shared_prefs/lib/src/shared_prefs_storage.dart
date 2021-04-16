import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_item_shared_prefs/single_item_shared_prefs.dart';
import 'package:single_item_storage/storage.dart';

/// [Storage] implementation that uses [SharedPreferences] and dart JSON
/// converters to store items.
class SharedPrefsStorage<E> implements Storage<E> {
  @protected
  final ToMap<E> toMap;
  @protected
  final FromMap<E> fromMap;
  @protected
  final String itemKey;
  @protected
  SharedPreferences? sharedPreferences;

  /// Makes a new instance using the provided [fromMap] and [toMap] item
  /// converters, [itemKey] as key in the [sharedPreferences] instance.
  ///
  /// If the [sharedPreferences] param is omitted,
  /// then [SharedPreferences.getInstance] is used.
  SharedPrefsStorage({
    required this.fromMap,
    required this.toMap,
    required this.itemKey,
    this.sharedPreferences,
  });

  @override
  Future<E> save(E item) async {
    await _ensurePreferencesSet();
    await sharedPreferences!.setString(itemKey, jsonEncode(toMap(item)));
    return item;
  }

  @override
  Future<E?> get() async {
    await _ensurePreferencesSet();
    final itemJson = sharedPreferences!.getString(itemKey);
    return itemJson == null ? null : fromMap(json.decode(itemJson));
  }

  @override
  Future<void> delete() async {
    await _ensurePreferencesSet();
    await sharedPreferences!.remove(itemKey);
  }

  Future<SharedPreferences> _ensurePreferencesSet() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    return sharedPreferences!;
  }
}
