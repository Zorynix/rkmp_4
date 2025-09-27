import 'subject.dart';

class SubjectRepository {
  static final SubjectRepository _instance = SubjectRepository._internal();
  factory SubjectRepository() => _instance;
  SubjectRepository._internal();

  final List<Subject> _subjects = [
    Subject(
      id: '1',
      name: 'Разработка кроссплатформенных мобильных приложений',
      teacher: 'Иванов И.И.',
      hours: 4,
      room: 'Ауд. 205',
    ),
    Subject(
      id: '2',
      name: 'Базы данных',
      teacher: 'Петров П.П.',
      hours: 3,
      room: 'Ауд. 301',
    ),
    Subject(
      id: '3',
      name: 'Веб-программирование',
      teacher: 'Сидоров С.С.',
      hours: 3,
      room: 'Ауд. 102',
    ),
    Subject(
      id: '4',
      name: 'Математический анализ',
      teacher: 'Козлов К.К.',
      hours: 5,
      room: 'Ауд. 412',
    ),
    Subject(
      id: '5',
      name: 'Физика',
      teacher: 'Орлов О.О.',
      hours: 4,
      room: 'Ауд. 234',
    ),
  ];

  List<Subject> get subjects => List.unmodifiable(_subjects);

  void addSubject(Subject subject) {
    _subjects.add(subject);
  }

  void removeSubject(String id) {
    _subjects.removeWhere((subject) => subject.id == id);
  }

  Subject? getSubjectById(String id) {
    try {
      return _subjects.firstWhere((subject) => subject.id == id);
    } catch (e) {
      return null;
    }
  }

  void updateSubject(Subject updatedSubject) {
    final index = _subjects.indexWhere((subject) => subject.id == updatedSubject.id);
    if (index != -1) {
      _subjects[index] = updatedSubject;
    }
  }
}
