import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../models/memory_item.dart';

class MemoryProvider extends ChangeNotifier {
  final List<MemoryItem> _memories = [];
  final ImagePicker _picker = ImagePicker();

  List<MemoryItem> get memories => List.unmodifiable(_memories);

  Future<void> pickImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: 80,
      );

      if (pickedFiles.isEmpty) return;

      for (final file in pickedFiles) {
        final bytes = await file.readAsBytes();

        _memories.add(
          MemoryItem(
            id: '${DateTime.now().microsecondsSinceEpoch}_${file.name}',
            imageBytes: bytes,
            dateAdded: DateTime.now(),
          ),
        );
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao selecionar imagens: $e');
    }
  }

  void removeMemory(String id) {
    _memories.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
