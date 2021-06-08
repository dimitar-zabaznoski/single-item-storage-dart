import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:single_item_secure_storage/src/secure_storage.dart';
import 'package:single_item_storage/storage.dart';

/// [Storage] implementation that uses [FlutterSecureStorage]
/// to store primitive items that don't need a converter.
///
/// Supported types: `bool`, `double`, `int` and `String`
class PrimitiveSecureStorage<E> extends SecureStorage<E> {
  PrimitiveSecureStorage(String itemKey, FlutterSecureStorage secureStorage)
      : assert(E == bool || E == double || E == int || E == String),
        super.base(itemKey, secureStorage);

  @override
  Future<E> save(E item) async {
    if (item is bool || item is double || item is int || item is String) {
      await secureStorage.write(key: itemKey, value: item.toString());
      return item;
    } else {
      throw ArgumentError('Item of unsupported type: ${E.runtimeType}');
    }
  }

  @override
  Future<E?> get() async {
    final storedValue = await secureStorage.read(key: itemKey);

    var result;
    if (E == bool) {
      result = storedValue?.toLowerCase() == 'true';
    } else if (E == double) {
      result = double.parse(storedValue!);
    } else if (E == int) {
      result = int.parse(storedValue!);
    } else if (E == String) {
      result = storedValue;
    }

    return result as E?;
  }
}
