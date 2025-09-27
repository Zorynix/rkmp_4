import 'package:flutter/material.dart';

class ItemData {
  final String id;
  final String text;
  final Color color;
  String inputText;

  ItemData(this.id, this.text, this.color, {this.inputText = ''});
}

class ColoredItem extends StatefulWidget {
  final ItemData itemData;
  final VoidCallback onTap;

  const ColoredItem({
    super.key,
    required this.itemData,
    required this.onTap,
  });

  @override
  State<ColoredItem> createState() => _ColoredItemState();
}

class _ColoredItemState extends State<ColoredItem> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.itemData.inputText);
  }

  @override
  void didUpdateWidget(ColoredItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.itemData.inputText != widget.itemData.inputText) {
      _controller.text = widget.itemData.inputText;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.itemData.color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: widget.itemData.color, width: 2),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: widget.itemData.color,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '•',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.itemData.text,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _controller,
                      onChanged: (value) {
                        widget.itemData.inputText = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Введи текст для ${widget.itemData.text}',
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Column(
                children: [
                  Icon(Icons.key, color: Colors.green),
                  Text('WITH KEY!', style: TextStyle(fontSize: 10, color: Colors.green)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleGestureKeyDemoScreen extends StatefulWidget {
  const SimpleGestureKeyDemoScreen({super.key});

  @override
  State<SimpleGestureKeyDemoScreen> createState() => _SimpleGestureKeyDemoScreenState();
}

class _SimpleGestureKeyDemoScreenState extends State<SimpleGestureKeyDemoScreen> {
  final items = [
    ItemData('1', 'Item 1', Colors.red),
    ItemData('2', 'Item 2', Colors.blue),
    ItemData('3', 'Item 3', Colors.green),
    ItemData('4', 'Item 4', Colors.orange),
    ItemData('5', 'Item 5', Colors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('С ключами - правильно!'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ColoredItem(
                  key: ValueKey(items[index].id),
                  itemData: items[index],
                  onTap: () => setState(() => items.removeAt(index)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
