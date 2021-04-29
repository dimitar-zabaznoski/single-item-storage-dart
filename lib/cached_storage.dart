import 'storage.dart';

/// Storage implementation wrapper that adds in-memory cache functionality.
///
/// _Use it to wrap time consuming or performance heavy storage implementations._
class CachedStorage<E> implements Storage<E> {
  final Storage<E> _inner;
  E? _cachedItem;
  bool _isItemFetched = false;

  CachedStorage(this._inner);

  /// Clears only the cached value.
  void clearCache() {
    _cachedItem = null;
    _isItemFetched = false;
  }

  /// Gets the item, uses the cached version if present. Otherwise, fetches a
  /// fresh value, caches, and returns it. On error throws.
  @override
  Future<E?> get() async {
    if (!_isItemFetched) {
      _cachedItem = await _inner.get();
      _isItemFetched = true;
    }
    return _cachedItem;
  }

  /// Saves and caches the item. On error throws.
  @override
  Future<E> save(E item) async {
    _cachedItem = await _inner.save(item);
    _isItemFetched = true;
    return _cachedItem!;
  }

  /// Deletes both actual and cached value. On error throws.
  @override
  Future<void> delete() async {
    _cachedItem = null;
    _isItemFetched = true;
    await _inner.delete();
  }
}
