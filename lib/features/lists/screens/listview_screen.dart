import 'package:flutter/material.dart';
import '../models/subject.dart';
import '../models/subject_repository.dart';
import '../widgets/subject_list_item.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  final SubjectRepository _repository = SubjectRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _teacherController = TextEditingController();
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _teacherController.dispose();
    _hoursController.dispose();
    _roomController.dispose();
    super.dispose();
  }

  void _addSubject() {
    if (_nameController.text.isEmpty ||
        _teacherController.text.isEmpty ||
        _hoursController.text.isEmpty ||
        _roomController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заполните все поля')),
      );
      return;
    }

    final hours = int.tryParse(_hoursController.text);
    if (hours == null || hours <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите корректное количество часов')),
      );
      return;
    }

    final newSubject = Subject(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      teacher: _teacherController.text.trim(),
      hours: hours,
      room: _roomController.text.trim(),
    );

    setState(() {
      _repository.addSubject(newSubject);
    });

    _nameController.clear();
    _teacherController.clear();
    _hoursController.clear();
    _roomController.clear();

    Navigator.of(context).pop();
  }

  void _deleteSubject(String id) {
    setState(() {
      _repository.removeSubject(id);
    });
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Добавить предмет'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Название предмета',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _teacherController,
                decoration: const InputDecoration(
                  labelText: 'Преподаватель',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _hoursController,
                decoration: const InputDecoration(
                  labelText: 'Количество часов',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _roomController,
                decoration: const InputDecoration(
                  labelText: 'Аудитория',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: _addSubject,
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.green.shade50,
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Этот экран использует ListView.builder для эффективного отображения списка предметов',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _repository.subjects.length,
              itemBuilder: (context, index) {
                final subject = _repository.subjects[index];
                return SubjectListItem(
                  key: ValueKey(subject.id),
                  subject: subject,
                  onDelete: () => _deleteSubject(subject.id),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
