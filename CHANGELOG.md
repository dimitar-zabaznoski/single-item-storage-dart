## [0.0.1]

* Initial version. Storage abstraction defined. In-memory cache implementations provided.

## [1.0.0]

* Added null safety
* __Breaking change:__ `storage.get()` is now nullable. Null is returned when an item is not found
* __Breaking change:__ `DataNotFound` exception is removed

## [1.0.1]

* Remove unused Flutter dependency.

## [1.0.2]

* Added StubStorage
* Added Observed Storage that has listener for changes