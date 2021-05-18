## 1.0.4

* Added silent Storage interactions to ObservedStorage.

  The following will not trigger `updates` or `updatesSticky`:
  
  `myObservedStorage.silent.save(item)`

## 1.0.3

* Used any version for async dependency to avoid version conflicts

## 1.0.2

* Added StubStorage
* Added Observed Storage that has listener for changes

## 1.0.1

* Remove unused Flutter dependency.

## 1.0.0

* Added null safety
* __Breaking change:__ `storage.get()` is now nullable. Null is returned when an item is not found
* __Breaking change:__ `DataNotFound` exception is removed

## 0.0.1

* Initial version. Storage abstraction defined. In-memory cache implementations provided.
