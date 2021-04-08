# single_item_storage

A single item storage abstraction with CRUD operations.
Use it for testing, easily swapping implementations, and abstracting complex 
storage implementations.  

This package provides a few implementations, but it's intended to be just a base 
for you to implement and provide specific implementation - file, shared preferences or user defaults, etc. 
To create your own, implement `Storage<E>`

Provided implementations:
- In-memory volatile implementation
- Cache implementation that wraps another storage implementation and adds caching capabilities. 
Useful when you have time consuming or performance heavy operations.

Example:
```
    Storage<String> storage = MemoryStorage<String>();
    
    // add/update item
    await storage.save('item_1');

    // retrieve item
    String? myItem = await itemStore.get();

    // delete item
    await storage.delete();
```
