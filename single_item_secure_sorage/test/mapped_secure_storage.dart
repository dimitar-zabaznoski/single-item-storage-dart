
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:single_item_secure_sorage/src/secure_storage.dart';

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

  setUp(() async {
    storage = SecureStorage<Place>(
        itemKey: 'model.place.key',
        toMap: (item) => item.toMap(),
        fromMap:  (map) => Place.fromMap(map)
    );
  });

  tearDown(() async {
    await storage.delete();
  });

  setupMockChannel(Place? place) {
    const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
        .setMockMethodCallHandler((MethodCall methodCall) async {

          if (place == null) {
            return null;
          }

          if (methodCall.method == 'write') {
            return jsonEncode(place.toMap());
          }

          if (methodCall.method == 'read') {
            return jsonEncode(place.toMap());
          }

          return null;
    });
  }

  test("VerifySharedPreferences", () async {
    setupMockChannel(theNorthPole);

    final savedItem = await storage.save(theNorthPole);

    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? itemInSecureStorage = await secureStorage.read(key: 'model.place.key');

    final Place retrievedItem = Place.fromJson(jsonDecode(itemInSecureStorage!));
    final bool keyInSecureStorage = await secureStorage.containsKey(key: 'model.place.key');

    expect(savedItem, equals(theNorthPole));
    expect(retrievedItem, equals(savedItem));
    expect(keyInSecureStorage, equals(true));
  });

  test("SaveOneFindOne", () async {
    setupMockChannel(theNorthPole);

    final savedItem = await storage.save(theNorthPole);
    final retrievedItem = await storage.get();

    expect(savedItem, equals(theNorthPole));
    expect(retrievedItem, equals(savedItem));
  });

  test("SaveOneFindOneNullValues", () async {
    setupMockChannel(veryNullPlace);

    final savedItem = await storage.save(veryNullPlace);
    final retrievedItem = await storage.get();

    expect(savedItem, equals(veryNullPlace));
    expect(retrievedItem, equals(savedItem));
  });

  test("SaveManyOverwrite", () async {
    setupMockChannel(veryNullPlace);
    final savedItem1 = await storage.save(veryNullPlace);
    setupMockChannel(theNorthPole);
    final savedItem2 = await storage.save(theNorthPole);
    final retrievedItem = await storage.get();

    expect(savedItem1, equals(veryNullPlace));
    expect(savedItem2, equals(theNorthPole));
    expect(retrievedItem, equals(savedItem2));
  });

  test("RetrieveNonExisting", () async {
    setupMockChannel(null);
    final retrievedItem = await storage.get();
    expect(retrievedItem, isNull);
  });

  test("Delete", () async {
    setupMockChannel(theNorthPole);
    await storage.save(theNorthPole);

    setupMockChannel(null);
    expect(storage.delete(), completes);
    expect(await storage.get(), isNull);
  });

  test("DeleteNonExisting", () async {
    setupMockChannel(null);

    expect(storage.delete(), completes);
    expect(await storage.get(), isNull);
  });
}