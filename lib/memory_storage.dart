import 'storage.dart';

/// In-memory implementation of [Storage].
/// Mind that this is volatile storage.
class MemoryStorage<E> implements Storage<E> {
  E? _item;

  @override
  Future<E> save(E item) => Future.sync(() {
        _item = item;
        return item;
      });

  @override
  Future<E?> get() => Future.sync(() => _item);

  @override
  Future<void> delete() => Future.sync(() {
        _item = null;
      });
}
