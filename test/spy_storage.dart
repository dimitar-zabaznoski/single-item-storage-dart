import 'package:mockito/mockito.dart';
import 'package:single_item_storage/storage.dart';

/// We use this class to capture events that we can `verify` later.
class VerificationStorage<E> extends Mock implements Storage<E> {
  @override
  Future<E> save(E item) {
    super.noSuchMethod(Invocation.method(#save, [item]));
    return Future.value(item);
  }

  @override
  Future<E?> get() {
    super.noSuchMethod(Invocation.method(#get, []));
    return Future.value(null);
  }

  @override
  Future<void> delete() {
    return super.noSuchMethod(Invocation.method(#delete, []));
  }
}

/// Adds spying capabilities to an actual Storage implementation.
/// Use `verificationStorage` for verifications.
/// Use `setInitialValue` or `actualStorage` to bypasses verification checks.
class SpyStorage<E> implements Storage<E> {
  final Storage<E> _actualStorage;
  final Storage<E> _verificationStorage;

  SpyStorage(this._actualStorage)
      : _verificationStorage = VerificationStorage();

  Storage<E> get verificationStorage => _verificationStorage;

  Storage<E> get actualStorage => _actualStorage;

  /// Bypasses verification checks
  Future<E> setInitialValue(E initialValue) =>
      _actualStorage.save(initialValue);

  @override
  Future<E> save(item) {
    _verificationStorage.save(item);
    return _actualStorage.save(item);
  }

  @override
  Future<E?> get() {
    _verificationStorage.get();
    return _actualStorage.get();
  }

  @override
  Future<void> delete() {
    _verificationStorage.delete();
    return _actualStorage.delete();
  }
}
