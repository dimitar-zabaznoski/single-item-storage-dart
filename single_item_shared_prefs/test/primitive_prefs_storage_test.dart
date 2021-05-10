import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_item_shared_prefs/src/primitive_prefs_storage.dart';
import 'package:single_item_shared_prefs/src/shared_prefs_storage.dart';

import 'test_classes.dart';

const itemKey = 'item_key';

/// Tests for [PrimitivePrefsStorage]
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  test('unsupported type constructor', () {
    expect(
      () => SharedPrefsStorage<Place>.primitive(itemKey: itemKey),
      throwsAssertionError,
    );
  });

  test('bool', () async {
    final storage = SharedPrefsStorage<bool>.primitive(itemKey: itemKey);
    // ignore: invalid_use_of_protected_member
    final SharedPreferences sharedPrefs = await storage.ensurePreferencesSet();

    final savedItem = await storage.save(true);
    final itemInSharedPrefs = sharedPrefs.getBool(itemKey)!;
    final retrievedItem = await storage.get();

    expect(true, equals(savedItem));
    expect(true, equals(itemInSharedPrefs));
    expect(true, equals(retrievedItem));

    await storage.delete();
  });

  test('double', () async {
    final storage = SharedPrefsStorage<double>.primitive(itemKey: itemKey);
    // ignore: invalid_use_of_protected_member
    final SharedPreferences sharedPrefs = await storage.ensurePreferencesSet();

    final savedItem = await storage.save(3.14);
    final itemInSharedPrefs = sharedPrefs.getDouble(itemKey)!;
    final retrievedItem = await storage.get();

    expect(3.14, equals(savedItem));
    expect(3.14, equals(itemInSharedPrefs));
    expect(3.14, equals(retrievedItem));

    await storage.delete();
  });

  test('int', () async {
    final storage = SharedPrefsStorage<int>.primitive(itemKey: itemKey);
    // ignore: invalid_use_of_protected_member
    final SharedPreferences sharedPrefs = await storage.ensurePreferencesSet();

    final savedItem = await storage.save(10);
    final itemInSharedPrefs = sharedPrefs.getInt(itemKey)!;
    final retrievedItem = await storage.get();

    expect(10, equals(savedItem));
    expect(10, equals(itemInSharedPrefs));
    expect(10, equals(retrievedItem));

    await storage.delete();
  });

  test('String', () async {
    final storage = SharedPrefsStorage<String>.primitive(itemKey: itemKey);
    // ignore: invalid_use_of_protected_member
    final SharedPreferences sharedPrefs = await storage.ensurePreferencesSet();

    final savedItem = await storage.save('message');
    final itemInSharedPrefs = sharedPrefs.getString(itemKey)!;
    final retrievedItem = await storage.get();

    expect('message', equals(savedItem));
    expect('message', equals(itemInSharedPrefs));
    expect('message', equals(retrievedItem));

    await storage.delete();
  });

  test('List<String>', () async {
    final storage =
        SharedPrefsStorage<List<String>>.primitive(itemKey: itemKey);
    // ignore: invalid_use_of_protected_member
    final SharedPreferences sharedPrefs = await storage.ensurePreferencesSet();

    final savedItem = await storage.save(['one', 'two']);
    final itemInSharedPrefs = sharedPrefs.getStringList(itemKey)!;
    final retrievedItem = await storage.get();

    expect(['one', 'two'], equals(savedItem));
    expect(['one', 'two'], equals(itemInSharedPrefs));
    expect(['one', 'two'], equals(retrievedItem));

    await storage.delete();
  });
}
