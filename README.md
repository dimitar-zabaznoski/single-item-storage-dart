# single_item_storage

A single item storage abstraction with CRUD operations.
Use it for abstracting storage implementations, for testing, quickly swapping implementations, etc.  

This package provides a few implementations, but it's intended to be just a base 
for you to implement and provide specific implementation - file, shared preferences or user defaults, etc. 
To create your own, implement `Storage<E>`

Base storage class definition:
```
    abstract class Storage<E> {
      
      Future<E> save(E item);
    
      Future<E?> get();
    
      Future<void> delete();
    }
```

## Provided implementations

In core module:
- **MemoryStorage** - In-memory volatile implementation
- **CachedStorage** - Wrapper implementation that adds caching capabilities. Use when you have time consuming or performance heavy operations.
- **ObservedStorage** - Wrapper implementation that notifies listeners when the data changes.
- **StubStorage** - Const implementation that won't store any items. Useful for default/null values.

In add-on modules:
- **SharedPrefsStorage**, in package [single_item_shared_prefs] - SharedPreferences[[⬈]][shared_preferences] implementation of `Storage<E>`
- **SecureStorage**, in package [single_item_secure_storage] - FlutterSecureStorage[[⬈]][flutter_secure_storage] implementation of `Storage<E>`

[shared_preferences]: https://pub.dev/packages/shared_preferences 
[flutter_secure_storage]: https://pub.dev/packages/flutter_secure_storage

[single_item_shared_prefs]: https://pub.dev/packages/single_item_shared_prefs
[single_item_secure_storage]: https://pub.dev/packages/single_item_secure_storage

## Example

### CRUD Operations:

```
    Storage<String> storage = MemoryStorage<String>();
    
    // add/update item
    await storage.save('item_1');

    // retrieve item
    String? myItem = await itemStore.get();

    // delete item
    await storage.delete();
```

### Mixing implementations

You can stack wrapper implementations to add behaviour.

```
    // The following sample will:
    // - use SharedPreferences to store data
    // - use in-memory cache when possible to save trips to the file system
    // - provide data change updates to subscribers to ObservedStorage
    
    ObservedStorage<Item> storage = ObservedStorage(CachedStorage(SharedPrefsStorage(...)));
```
