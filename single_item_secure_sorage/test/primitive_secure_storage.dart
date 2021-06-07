
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:single_item_secure_sorage/src/secure_storage.dart';

import 'test_classes.dart';

const itemKey = 'item_key';

/// Tests for [PrimitiveSecureStorage]
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();


  test('unsupported type constructor', () {
    expect(
          () => SecureStorage<Place>.primitive(itemKey: itemKey),
      throwsAssertionError,
    );
  });

  test('bool', () async {
    const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'write') {
        return 'true';
      }

      if (methodCall.method == 'read') {
        return 'true';
      }

      return null;
    });

    final storage = SecureStorage<bool>.primitive(itemKey: itemKey);
    final FlutterSecureStorage secureStorage = await storage.ensureStorageSet();

    final savedItem = await storage.save(true);
    final itemInStorage = await secureStorage.read(key: itemKey);
    final retrievedItem = await storage.get();

    expect(true, equals(savedItem));
    expect('true', equals(itemInStorage));
    expect(true, equals(retrievedItem));

    await storage.delete();
  });

  test('string', () async {
    const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'write') {
        return 'test_string';
      }

      if (methodCall.method == 'read') {
        return 'test_string';
      }

      return null;
    });

    final storage = SecureStorage<String>.primitive(itemKey: itemKey);
    final FlutterSecureStorage secureStorage = await storage.ensureStorageSet();

    final savedItem = await storage.save('test_string');
    final itemInStorage = await secureStorage.read(key: itemKey);
    final retrievedItem = await storage.get();

    expect('test_string', equals(savedItem));
    expect('test_string', equals(itemInStorage));
    expect('test_string', equals(retrievedItem));

    await storage.delete();
  });

  test('double', () async {
    const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'write') {
        return '3.14';
      }

      if (methodCall.method == 'read') {
        return '3.14';
      }

      return null;
    });

    final storage = SecureStorage<double>.primitive(itemKey: itemKey);
    final FlutterSecureStorage secureStorage = await storage.ensureStorageSet();

    final savedItem = await storage.save(3.14);
    final itemInStorage = await secureStorage.read(key: itemKey);
    final retrievedItem = await storage.get();

    expect(3.14, equals(savedItem));
    expect('3.14', equals(itemInStorage));
    expect(3.14, equals(retrievedItem));

    await storage.delete();
  });

  test('int', () async {
    const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'write') {
        return '10';
      }

      if (methodCall.method == 'read') {
        return '10';
      }

      return null;
    });

    final storage = SecureStorage<int>.primitive(itemKey: itemKey);
    final FlutterSecureStorage secureStorage = await storage.ensureStorageSet();

    final savedItem = await storage.save(10);
    final itemInStorage = await secureStorage.read(key: itemKey);
    final retrievedItem = await storage.get();

    expect(10, equals(savedItem));
    expect('10', equals(itemInStorage));
    expect(10, equals(retrievedItem));

    await storage.delete();
  });
}
