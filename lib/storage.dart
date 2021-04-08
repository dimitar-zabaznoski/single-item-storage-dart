library storage;

/// Single item store.
///
/// Abstraction over a single item storage. Useful for testing,
/// easy switching of implementations and combining/abstracting multiple
/// implementations - for example: memory-cache + file implementation.
abstract class Storage<E> {
  /// Saves the given item, overriding any previous entries.
  Future<E> save(E item);

  /// Retrieves the saved item or returns `null` if no item is found.
  Future<E?> get();

  /// Deletes any written item. If no item is found completes without error.
  Future<void> delete();
}
