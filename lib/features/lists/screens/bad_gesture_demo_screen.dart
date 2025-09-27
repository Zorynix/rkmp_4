import 'package:flutter/material.dart';

class ColoredItem extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const ColoredItem({
    super.key,
    required this.text,
    required this.color,
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
    _controller = TextEditingController();
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
            color: widget.color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: widget.color, width: 2),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: widget.color,
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
                      widget.text,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Введи текст для ${widget.text}',
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
                  Icon(Icons.warning, color: Colors.red),
                  Text('NO KEY!', style: TextStyle(fontSize: 10, color: Colors.red)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BadGestureDemoScreen extends StatefulWidget {
  const BadGestureDemoScreen({super.key});

  @override
  State<BadGestureDemoScreen> createState() => _BadGestureDemoScreenState();
}

class _BadGestureDemoScreenState extends State<BadGestureDemoScreen> {
  final items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Без ключей - проблема!'),
        backgroundColor: Colors.red.shade700,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ColoredItem(
                  text: items[index],
                  color: colors[index],
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
