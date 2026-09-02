# Image Gallery - Diário de Memórias

Aplicativo Flutter para selecionar imagens e exibi-las em uma galeria.

## Estrutura

```text
lib/
├── models/
│   └── memory_item.dart
├── providers/
│   └── memory_provider.dart
├── screens/
│   ├── home_screen.dart
│   └── detail_screen.dart
└── main.dart
```

## Funcionamento

O aplicativo utiliza `image_picker` para selecionar múltiplas imagens.

As imagens são convertidas em bytes:

```dart
final bytes = await file.readAsBytes();
```

E exibidas com:

```dart
Image.memory(item.imageBytes)
```

Essa abordagem funciona no Flutter Web.

## Funcionalidades

- Seleção de múltiplas imagens;
- Exibição em grade;
- Tela de detalhes;
- Zoom;
- Exclusão de imagens;
- Provider para gerenciamento de estado;
- Botão Salvar;
- BottomSheet com resumo dos dados coletados.
"# Di-rio" 
