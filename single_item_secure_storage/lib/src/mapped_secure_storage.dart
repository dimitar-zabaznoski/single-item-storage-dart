import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:single_item_secure_storage/src/map_adapter.dart';
import 'package:single_item_secure_storage/src/secure_storage.dart';
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
      String itemKey,
      FlutterSecureStorage secureStorage, {
        IOSOptions? iosOptions,
        AndroidOptions? androidOptions,
      }) : super.base(
    itemKey,
    secureStorage,
    iosOptions: iosOptions,
    androidOptions: androidOptions,
  );

  @override
  Future<E> save(E item) async {
    print('Options ${iosOptions?.params.toString()}');

    await secureStorage.write(
      key: itemKey,
      value: jsonEncode(toMap(item)),
      iOptions: iosOptions,
      aOptions: androidOptions,
    );

    return item;
  }

  @override
  Future<E?> get() async {
    final String? itemJson = await secureStorage.read(
      key: itemKey,
      iOptions: iosOptions,
      aOptions: androidOptions,
    );

    return itemJson == null ? null : fromMap(jsonDecode(itemJson));
  }
}
