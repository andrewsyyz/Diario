import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/memory_provider.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showSummaryBottomSheet(BuildContext context) {
    final memories = context.read<MemoryProvider>().memories;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resumo dos Dados Coletados',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Total de imagens'),
                      trailing: Text(
                        '${memories.length}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Imagens selecionadas:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: memories.isEmpty
                        ? const Center(
                            child: Text('Nenhuma imagem foi adicionada.'),
                          )
                        : ListView.builder(
                            itemCount: memories.length,
                            itemBuilder: (context, index) {
                              final item = memories[index];

                              return Card(
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.memory(
                                      item.imageBytes,
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text('Imagem ${index + 1}'),
                                  subtitle: Text(
                                    'Data: '
                                    '${item.dateAdded.day.toString().padLeft(2, '0')}/'
                                    '${item.dateAdded.month.toString().padLeft(2, '0')}/'
                                    '${item.dateAdded.year} '
                                    '${item.dateAdded.hour.toString().padLeft(2, '0')}:'
                                    '${item.dateAdded.minute.toString().padLeft(2, '0')}',
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.check),
                      label: const Text('Fechar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final memoryProvider = context.watch<MemoryProvider>();
    final memories = memoryProvider.memories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diário de Memórias'),
        centerTitle: true,
      ),
      body: memories.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma memória adicionada ainda.\n'
                'Clique em Adicionar Fotos para começar!',
                textAlign: TextAlign.center,
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: memories.length,
              itemBuilder: (context, index) {
                final item = memories[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(
                          imageBytes: item.imageBytes,
                          memoryId: item.id,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      item.imageBytes,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'save',
            onPressed: () => _showSummaryBottomSheet(context),
            icon: const Icon(Icons.save),
            label: const Text('Salvar'),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'add',
            onPressed: memoryProvider.pickImages,
            icon: const Icon(Icons.add_a_photo),
            label: const Text('Adicionar Fotos'),
          ),
        ],
      ),
    );
  }
}
