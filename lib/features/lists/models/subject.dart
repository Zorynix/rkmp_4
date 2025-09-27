class Subject {
  final String id;
  final String name;
  final String teacher;
  final int hours;
  final String room;

  Subject({
    required this.id,
    required this.name,
    required this.teacher,
    required this.hours,
    required this.room,
  });

  Subject copyWith({
    String? id,
    String? name,
    String? teacher,
    int? hours,
    String? room,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      teacher: teacher ?? this.teacher,
      hours: hours ?? this.hours,
      room: room ?? this.room,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Subject && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
