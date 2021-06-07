import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:single_item_secure_sorage/src/map_adapter.dart';
import 'package:single_item_secure_sorage/src/secure_storage.dart';
import 'package:single_item_storage/storage.dart';

/// [Storage] implementation that uses [FlutterSecureStorage] and dart JSON
/// converters to store items.
class MappedSecureStorage<E> extends SecureStorage<E> {
  @protected
  final ToMap<E> toMap;
  @protected
  final FromMap<E> fromMap;

  /// Makes a new instance using the provided [fromMap] and [toMap] item
  /// converters, [itemKey] as key in the [secureStorage] instance.
  MappedSecureStorage(
      this.toMap,
      this.fromMap,
      String itemKey, [
        FlutterSecureStorage? secureStorage,
      ]) : super.base(itemKey, secureStorage);

  @override
  Future<E> save(E item) async {
    await ensureStorageSet();
    await secureStorage!.write(key: itemKey, value: jsonEncode(toMap(item)));

    return item;
  }

  @override
  Future<E?> get() async {
    await ensureStorageSet();
    final String? itemJson = await secureStorage!.read(key: itemKey);

    return itemJson == null ? null : fromMap(jsonDecode(itemJson));
  }
}
