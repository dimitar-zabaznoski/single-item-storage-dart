# single_item_secure_storage

Keychain/Keystore persistent Storage implementation.

This package is an addon to the [single_item_storage] package and offers
a Storage implementation using the [flutter_secure_storage] package and dart 
JSON converters, `json.encode` and `json.decode`, to store items.

[single_item_storage]: https://pub.dev/packages/single_item_storage
[flutter_secure_storage]: https://pub.dev/packages/flutter_secure_storage

# Getting started

Create a new instance by providing `fromMap` and `toMap` item 
converters, `itemKey` as key for this item in keychain,
and an optional `secureStore` instance. Additionally you can add iOS and Android options.
If options are not added, the default ones will be used.  

    Storage<User> storage = CachedStorage<User>(SecureStorage(
      itemKey: 'model.user.key',
      fromMap: (map) => User.fromMap(map),
      toMap: (item) => item.toMap(),
      iosOptions: IOSOptions(), 
      androidOptions: AndroidOptions(),
    ));

    @JsonSerializable()
    class User {
      final String id;
      final String email;
    
      factory User.fromMap(Map<String, dynamic> json) => _$UserFromJson(json);
      Map<String, dynamic> toMap() => _$UserToJson(this);
    
      User(this.id, this.email);
    }

To store primitive values that don't need a converter use the .primitive named constructor.

    /* Supported primitive types: 
     - bool
     - double
     - int
     - String
     */
    SecureStorage<int>.primitive(itemKey: 'cow_counter')

If the `secureStorage` is omitted, then an instance of `FlutterSecureStorage` is used.

When defining the to/from map converter mind that the map values can only be: 
number, boolean, string, null, list or a map with string keys as defined in 
`json.encode` and `json.decode` from the `dart:convert` package.

_This example uses [json_serializable] as Map converter for convenience._

[json_serializable]: https://pub.dev/packages/json_serializable

# Android Usage

### Encrypted Shared Preferences

Configure use of encrypted shared preferences with android options in constructor:
```
androidOptions: AndroidOptions(encryptedSharedPreferences: true),
```

# iOS usage

### Keychain Accessibility

Configure keychain accessibility with iOS options in constructor:
```
iosOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
```

### Secure Storage Lifetime

On iOS the secure storage is not deleted when the app is uninstalled.
This is sometimes desired and other times not,
whatever the case keep it in mind when designing your use case.
More information can be found on the following [link][ios_app_uninstall].

[ios_app_uninstall]: https://developer.apple.com/forums/thread/36442