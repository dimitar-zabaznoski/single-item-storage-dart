## 2.1.0

* Update minimum supported SDK version to Flutter 3.22/Dart 3.4

## 2.0.1

* Add privacy policy files for iOS

## 2.0.0

__*Breaking:__
* Require Dart 3.1
* Require Flutter >=3.13
* Require Android SDK 34

## 1.0.5

* Dependencies update

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
