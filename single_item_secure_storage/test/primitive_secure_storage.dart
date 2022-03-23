import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:single_item_secure_storage/src/secure_storage.dart';

import 'mock_method_handler.dart';
import 'test_classes.dart';

const itemKey = 'item_key';

/// Tests for [PrimitiveSecureStorage]
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
        .setMockMethodCallHandler(mockMethodHandler());
  });

  test('unsupported type constructor', () {
    expect(
      () => SecureStorage<Place>.primitive(itemKey: itemKey),
      throwsAssertionError,
    );
  });

  test('bool', () async {
    final storage = SecureStorage<bool>.primitive(itemKey: itemKey);
    // ignore: invalid_use_of_protected_member
    final FlutterSecureStorage secureStorage = storage.secureStorage;

    final savedItem = await storage.save(true);
    final itemInStorage = await secureStorage.read(key: itemKey);
    final retrievedItem = await storage.get();

    expect(true, equals(savedItem));
    expect('true', equals(itemInStorage));
    expect(true, equals(retrievedItem));

    await storage.delete();
  });

  test('string', () async {
    final storage = SecureStorage<String>.primitive(itemKey: itemKey);
    // ignore: invalid_use_of_protected_member
    final FlutterSecureStorage secureStorage = storage.secureStorage;

    final savedItem = await storage.save('test_string');
    final itemInStorage = await secureStorage.read(key: itemKey);
    final retrievedItem = await storage.get();

    expect('test_string', equals(savedItem));
    expect('test_string', equals(itemInStorage));
    expect('test_string', equals(retrievedItem));

    await storage.delete();
  });

  test('double', () async {
    final storage = SecureStorage<double>.primitive(itemKey: itemKey);
    // ignore: invalid_use_of_protected_member
    final FlutterSecureStorage secureStorage = storage.secureStorage;

    final savedItem = await storage.save(3.14);
    final itemInStorage = await secureStorage.read(key: itemKey);
    final retrievedItem = await storage.get();

    expect(3.14, equals(savedItem));
    expect('3.14', equals(itemInStorage));
    expect(3.14, equals(retrievedItem));

    await storage.delete();
  });

  test('int', () async {
    final storage = SecureStorage<int>.primitive(itemKey: itemKey);
    // ignore: invalid_use_of_protected_member
    final FlutterSecureStorage secureStorage = storage.secureStorage;

    final savedItem = await storage.save(10);
    final itemInStorage = await secureStorage.read(key: itemKey);
    final retrievedItem = await storage.get();

    expect(10, equals(savedItem));
    expect('10', equals(itemInStorage));
    expect(10, equals(retrievedItem));

    await storage.delete();
  });
}
