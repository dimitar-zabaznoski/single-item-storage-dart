# single_item_shared_prefs

SharedPreferences/UserDefaults persistent Storage implementation.

This package is an addon to the [single_item_storage] package and offers
a Storage implementation using the [shared_preferences] package and dart 
JSON converters, `json.encode` and `json.decode`, to store items.

[single_item_storage]: https://pub.dev/packages/single_item_storage
[shared_preferences]: https://pub.dev/packages/shared_preferences

# Getting started

Create a new instance by providing `fromMap` and `toMap` item 
converters, `itemKey` as key for this item in shared preferences,
and an optional `sharedPreferences` instance. 

    Storage<User> storage = CachedStorage<User>(SharedPrefsStorage(
      itemKey: 'model.user.key',
      fromMap: (map) => User.fromMap(map),
      toMap: (item) => item.toMap(),
    ));
    
    @JsonSerializable()
    class User {
      final String id;
      final String email;
    
      factory User.fromMap(Map<String, dynamic> json) => _$UserFromJson(json);
      Map<String, dynamic> toMap() => _$UserToJson(this);
    
      User(this.id, this.email);
    }

If the `sharedPreferences` is omitted, then `SharedPreferences.getInstance` is used.

Notice that the `SharedPrefsStorage` is wrapped in `CachedStorage` to add in-memory
caching for better performance.

When defining the to/from map converter mind that the map values can only be: 
number, boolean, string, null, list or a map with string keys. As defined in 
`json.encode` and `json.decode` from the `dart:convert` package.

_This example uses [json_serializable] as Map converter for convenience._

[json_serializable]: https://pub.dev/packages/json_serializable
