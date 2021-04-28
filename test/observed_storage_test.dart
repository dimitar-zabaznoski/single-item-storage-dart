import 'package:single_item_storage/memory_storage.dart';
import 'package:single_item_storage/observed_storage.dart';
import 'package:test/test.dart';

import 'storage_base_test.dart';

const String item = 'item';

/// Tests for [ObservedStorage]
void main() {
  /* Base tests for the `Storage` methods */

  executeStorageBaseTests(() => ObservedStorage(MemoryStorage()));

  /* Tests specific for this implementation in addition to the base tests */

  late ObservedStorage<int> itemStore;

  setUp(() {
    itemStore = ObservedStorage(MemoryStorage());
  });

  test('updates no value preset', () async {
    expect(itemStore.updates, emitsInOrder([1, 2, 3]));

    await itemStore.save(1);
    await itemStore.save(2);
    await itemStore.save(3);
  });

  test('updates value preset', () async {
    await itemStore.save(5);

    expect(itemStore.updates, emitsInOrder([0, 1, 0]));

    await itemStore.save(0);
    await itemStore.save(1);
    await itemStore.save(0);
  });

  test('updatesSticky no value preset', () async {
    expect(itemStore.updatesSticky, emitsInOrder([5, 10]));

    await itemStore.save(5);
    await itemStore.save(10);
  });

  test('updatesSticky value preset', () async {
    await itemStore.save(-1);

    expect(itemStore.updatesSticky, emitsInOrder([-1, 5, 10]));

    await itemStore.save(5);
    await itemStore.save(10);
  });

  test('updates null', () async {
    await itemStore.save(-1);

    expect(itemStore.updates, emitsInOrder([isNull]));

    itemStore.delete();
  });

  test('no updates', () async {
    expect(itemStore.updatesSticky, emitsInOrder([]));

    itemStore.updatesSticky.listen((_) {});
  });

  test('updates nullable values', () async {
    ObservedStorage<int?> itemStore = ObservedStorage(MemoryStorage());

    expect(itemStore.updates, emitsInOrder([1, null, 3]));

    await itemStore.save(1);
    await itemStore.save(null);
    await itemStore.save(3);
  });
}
