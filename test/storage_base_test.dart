import 'package:flutter_test/flutter_test.dart';
import 'package:single_item_storage/storage.dart';

void main() {}

const String item1 = 'item 1';
const String item2 = 'item 2';

/// Base tests for [Storage].
void executeStorageBaseTests(Storage<String> createStorage()) {
  late Storage<String> storage;

  setUp(() {
    storage = createStorage();
  });

  test('SaveOneFindOne', () async {
    var savedItem = await storage.save(item1);
    var retrievedItem = await storage.get();

    expect(savedItem, equals(item1));
    expect(retrievedItem, equals(savedItem));
  });

  test('SaveManyOverwrite', () async {
    var savedItem1 = await storage.save(item1);
    var savedItem2 = await storage.save(item2);
    var retrievedItem = await storage.get();

    expect(savedItem1, equals(item1));
    expect(savedItem2, equals(item2));
    expect(retrievedItem, equals(savedItem2));
  });

  test('RetrieveNonExisting', () async {
    expect(storage.get(), completion(isNull));
  });

  test('Delete', () async {
    await storage.save(item1);

    await storage.delete();

    expect(storage.get(), completion(isNull));
  });

  test('DeleteNonExisting', () async {
    await storage.delete();

    expect(storage.get(), completion(isNull));
  });
}
