import 'package:mockito/mockito.dart';
import 'package:single_item_storage/cached_storage.dart';
import 'package:single_item_storage/memory_storage.dart';
import 'package:test/test.dart';

import 'spy_storage.dart';
import 'storage_base_test.dart';

const String item = 'item';

/// Tests for [CachedStorage]
void main() {

  /* Base tests for the `Storage` methods */

  executeStorageBaseTests(() => CachedStorage(MemoryStorage()));

  /* Tests specific for this implementation in addition to the base tests */

  late CachedStorage<String> itemStore;
  late SpyStorage<String> innerStorage;

  setUp(() {
    innerStorage = SpyStorage(MemoryStorage());
    itemStore = CachedStorage(innerStorage);
  });

  group('Verify actual interactions', () {
    test('Get empty', () async {
      final actualItem1 = await itemStore.get();
      final actualItem2 = await itemStore.get();

      expect(actualItem1, isNull);
      expect(actualItem2, isNull);
      verify(innerStorage.verificationStorage.get()).called(1);
    });

    test('Get not empty', () async {
      await innerStorage.setInitialValue(item);

      final actualItem1 = await itemStore.get();
      final actualItem2 = await itemStore.get();
      await itemStore.get();
      final actualItemN = await itemStore.get();

      expect(actualItem1, equals(item));
      expect(actualItem2, equals(item));
      expect(actualItemN, equals(item));
      verify(innerStorage.verificationStorage.get()).called(1);
    });

    test('Get cached', () async {
      await itemStore.save(item);

      final actualItem1 = await itemStore.get();
      final actualItem2 = await itemStore.get();

      expect(actualItem1, equals(item));
      expect(actualItem2, equals(item));
      verifyNever(innerStorage.verificationStorage.get());
    });

    test('Clear cache', () async {
      final actualItem1 = await itemStore.get();
      itemStore.clearCache();
      final actualItem2 = await itemStore.get();

      expect(actualItem1, isNull);
      expect(actualItem2, isNull);
      verify(innerStorage.verificationStorage.get()).called(2);
    });
  });
}
