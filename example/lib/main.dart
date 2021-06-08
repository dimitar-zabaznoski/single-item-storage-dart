import 'package:flutter/widgets.dart';
import 'package:single_item_secure_storage/single_item_secure_sorage.dart';
import 'package:single_item_shared_prefs/single_item_shared_prefs.dart';
import 'package:single_item_storage/cached_storage.dart';
import 'package:single_item_storage/storage.dart';

import 'user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //
  // Shared Preferences
  //
  {
    Storage<User> storage = SharedPrefsStorage<User>(
      itemKey: 'model.user.key',
      fromMap: (map) => User.fromMap(map),
      toMap: (item) => item.toMap(),
    );

    benchmark('SharedPrefs - Save', () => storage.save(User.demo()));
    benchmark('SharedPrefs - Get', () => storage.get());
    benchmark('SharedPrefs - Delete', () => storage.delete());
  }

  //
  // Encrypted Storage - object item
  //
  {
    Storage<User> storage = SecureStorage<User>(
      itemKey: 'model.user.key.object',
      fromMap: (map) => User.fromMap(map),
      toMap: (item) => item.toMap(),
    );

    benchmark('Encrypted Object - Save', () => storage.save(User.demo()));
    benchmark('Encrypted Object - Get', () => storage.get());
    benchmark('Encrypted Object - Delete', () => storage.delete());
  }

  //
  // Encrypted Storage - primitive item
  //
  {
    Storage<String> storage = SecureStorage<String>.primitive(
      itemKey: 'model.user.key.primitive',
    );

    final token = User.demo().credentials.token;
    benchmark('Encrypted String - Save', () => storage.save(token));
    benchmark('Encrypted String - Get', () => storage.get());
    benchmark('Encrypted String - Delete', () => storage.delete());
  }

  // Cached Storage
  //
  // Wrap performance heavy storage implementations with
  // cached storage to optimize performance.
  {
    Storage<String> storage = CachedStorage(SecureStorage.primitive(
      itemKey: 'model.user.key.primitive.cached',
    ));

    await benchmark('Cached storage - Save', () => storage.save('0123456789'));
    await benchmark('Cached storage - Get', () => storage.get());
    await benchmark('Cached storage - Delete', () => storage.delete());
  }
}

Future<void> benchmark(String title, Future operation()) async {
  Stopwatch stopwatch = Stopwatch()..start();
  await operation();
  stopwatch.stop();
  print('$title elapsedMillis: ${stopwatch.elapsedMilliseconds}');
}
