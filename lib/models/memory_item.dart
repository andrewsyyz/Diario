import 'dart:typed_data';

class MemoryItem {
  final String id;
  final Uint8List imageBytes;
  final DateTime dateAdded;

  MemoryItem({
    required this.id,
    required this.imageBytes,
    required this.dateAdded,
  });
}
