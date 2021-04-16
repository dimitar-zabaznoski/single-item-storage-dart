import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_item_shared_prefs/src/shared_prefs_storage.dart';

import 'test_classes.dart';

final Place theNorthPole = Place(
  "North Pole",
  Coordinates(90.0, 135.0),
  nearbyGasPumps: ['BP', 'Shell'],
  nearbyMcDonalds: [],
  nearbyToilets: [Coordinates(51.5074, 0.1278)],
);

final Place veryNullPlace = Place(
  "very null place",
  null,
  nearbyGasPumps: [],
  nearbyMcDonalds: [],
  nearbyToilets: [],
);

/// Tests for [SharedPrefsStorage]
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  late SharedPrefsStorage<Place> storage;

  setUp(() async {
    storage = SharedPrefsStorage<Place>(
      itemKey: 'model.place.key',
      fromMap: (map) => Place.fromMap(map),
      toMap: (item) => item.toMap(),
    );
  });

  tearDown(() async {
    await storage.delete();
  });

  test("VerifySharedPreferences", () async {
    final savedItem = await storage.save(theNorthPole);

    // ignore: invalid_use_of_protected_member
    final SharedPreferences sharedPrefs = storage.sharedPreferences!;
    final String itemInSharedPrefs = sharedPrefs.getString('model.place.key')!;
    final Place retrievedItem = Place.fromJson(json.decode(itemInSharedPrefs));
    final Set<String> keysInSharedPrefs = sharedPrefs.getKeys();

    expect(savedItem, equals(theNorthPole));
    expect(retrievedItem, equals(savedItem));
    expect(keysInSharedPrefs, equals(['model.place.key']));
  });

  test("SaveOneFindOne", () async {
    final savedItem = await storage.save(theNorthPole);
    final retrievedItem = await storage.get();

    expect(savedItem, equals(theNorthPole));
    expect(retrievedItem, equals(savedItem));
  });

  test("SaveOneFindOneNullValues", () async {
    final savedItem = await storage.save(veryNullPlace);
    final retrievedItem = await storage.get();

    expect(savedItem, equals(veryNullPlace));
    expect(retrievedItem, equals(savedItem));
  });

  test("SaveManyOverwrite", () async {
    final savedItem1 = await storage.save(veryNullPlace);
    final savedItem2 = await storage.save(theNorthPole);
    final retrievedItem = await storage.get();

    expect(savedItem1, equals(veryNullPlace));
    expect(savedItem2, equals(theNorthPole));
    expect(retrievedItem, equals(savedItem2));
  });

  test("RetrieveNonExisting", () async {
    final retrievedItem = await storage.get();
    expect(retrievedItem, isNull);
  });

  test("Delete", () async {
    await storage.save(theNorthPole);

    expect(storage.delete(), completes);
    expect(await storage.get(), isNull);
  });

  test("DeleteNonExisting", () async {
    expect(storage.delete(), completes);
    expect(await storage.get(), isNull);
  });
}
