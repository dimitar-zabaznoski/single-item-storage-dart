import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:single_item_secure_storage/src/secure_storage.dart';

import 'mock_method_handler.dart';
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

/// Tests for [MappedSecureStorage]
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SecureStorage<Place> storage;

  setUp(() {
    const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
        .setMockMethodCallHandler(mockMethodHandler());

    storage = SecureStorage<Place>(
        itemKey: 'model.place.key',
        toMap: (item) => item.toMap(),
        fromMap: (map) => Place.fromMap(map));
  });

  tearDown(() async {
    await storage.delete();
  });

  test("VerifyItemActuallySaved", () async {
    final savedItem = await storage.save(theNorthPole);

    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? itemInSecureStorage =
        await secureStorage.read(key: 'model.place.key');

    final Place retrievedItem =
        Place.fromJson(jsonDecode(itemInSecureStorage!));
    final bool keyInSecureStorage =
        await secureStorage.containsKey(key: 'model.place.key');

    expect(savedItem, equals(theNorthPole));
    expect(retrievedItem, equals(savedItem));
    expect(keyInSecureStorage, equals(true));
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
