import 'dart:async';

import 'package:async/async.dart';
import 'package:single_item_storage/storage.dart';

/// Wrapper around [Storage] that notifies listeners when data change happens.
///
/// Use [updates] and [updatesSticky] to subscribe to update events.
class ObservedStorage<E> implements Storage<E> {
  final Storage<E> _inner;
  final StreamController<E?> _streamController = StreamController.broadcast();

  E? _lastEmittedItem;
  bool _hasEmittedItem = false;

  ObservedStorage(this._inner);

  /// Returns a broadcast stream that emits updates when the data changes.
  /// [null] is a valid emitted item if E? is nullable or the item E is deleted.
  Stream<E?> get updates => _streamController.stream;

  /// Returns a broadcast stream that emits updates when the data changes,
  /// starting with any last emitted item first.
  /// [null] is a valid emitted item if E? is nullable or the item E is deleted.
  Stream<E?> get updatesSticky => (StreamGroup<E?>.broadcast()
        ..add(_hasEmittedItem ? Stream.value(_lastEmittedItem) : Stream.empty())
        ..add(_streamController.stream))
      .stream;

  Future<E?> get() => _inner.get();

  @override
  Future<void> delete() async {
    await _inner.delete();
    _addUpdate(null);
  }

  @override
  Future<E> save(E item) async {
    final savedItem = await _inner.save(item);
    _addUpdate(item);
    return savedItem;
  }

  void _addUpdate(E? event) {
    _hasEmittedItem = true;
    _lastEmittedItem = event;
    _streamController.add(event);
  }

  /// Permanently closes this updates stream.
  Future<void> teardown() => _streamController.close();
}
