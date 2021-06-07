
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:single_item_secure_sorage/src/map_adapter.dart';
import 'package:single_item_secure_sorage/src/mapped_secure_storage.dart';
import 'package:single_item_secure_sorage/src/primitive_secure_storage.dart';
import 'package:single_item_storage/storage.dart';

/// [Storage] implementation that uses [FlutterSecureStorage] to store items.
abstract class SecureStorage<E> implements Storage<E> {
  @protected
  final String itemKey;
  @protected
  FlutterSecureStorage? secureStorage;

  /// Makes a new instance using the provided [fromMap] and [toMap] item
  /// converters, [itemKey] as key in the [secureStorage] instance.
  ///
  /// If the [secureStorage] param is omitted,
  /// then a new instance of [FlutterSecureStorage] is used.
  factory SecureStorage({
    required ToMap<E> toMap,
    required FromMap<E> fromMap,
    required String itemKey,
    FlutterSecureStorage? secureStorage,
  }) =>
      MappedSecureStorage(toMap, fromMap, itemKey, secureStorage);

  /// [Storage] implementation that uses [FlutterSecureStorage]
  /// to store primitive items that don't need a converter.
  ///
  /// Supported types: `bool`, `double`, `int`, `String`.
  factory SecureStorage.primitive({
    required String itemKey,
    FlutterSecureStorage? sharedPreferences,
  }) =>
      PrimitiveSecureStorage(itemKey, sharedPreferences);

  @protected
  SecureStorage.base(this.itemKey, [this.secureStorage]);

  @override
  Future<void> delete() async {
    await ensureStorageSet();
    await secureStorage!.delete(key: itemKey);
  }

  @protected
  Future<FlutterSecureStorage> ensureStorageSet() async {
    if (secureStorage == null) {
      secureStorage = FlutterSecureStorage();
    }
    return secureStorage!;
  }
}
