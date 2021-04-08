import 'package:single_item_storage/memory_storage.dart';
import 'storage_base_test.dart';

/// Tests for [MemoryStorage]
void main() {
  executeStorageBaseTests(() => MemoryStorage<String>());
}
