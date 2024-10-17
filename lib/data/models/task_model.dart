class Task {
  final int? id;
  final String title;
  final String description;
  final String date;
  final bool isCompleted;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }
}
