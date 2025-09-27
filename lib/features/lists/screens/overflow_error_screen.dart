import 'package:flutter/material.dart';

class OverflowErrorScreen extends StatefulWidget {
  const OverflowErrorScreen({super.key});

  @override
  State<OverflowErrorScreen> createState() => _OverflowErrorScreenState();
}

class _OverflowErrorScreenState extends State<OverflowErrorScreen> {
  @override
  Widget build(BuildContext context) {
    final items = List.generate(50, (index) => 'Item ${index + 1}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ошибка переполнения'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items.map((item) => Text(item)).toList(),
      ),
    );
  }
}
