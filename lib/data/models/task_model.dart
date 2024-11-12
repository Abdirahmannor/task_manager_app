class Task {
  final int? id;
  final String title;
  final String description;
  final String date;
  final bool isCompleted;
  final String category; // Ensure category is defined
  final String priority; // Add this line

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
    required this.category, // Include category in constructor
    required this.priority, // Add this line
  });

  // Convert a Task into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isCompleted': isCompleted ? 1 : 0,
      'category': category, // Ensure this is included
      'priority': priority, // Add this line
    };
  }

  // Convert a Map into a Task.
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      isCompleted: map['isCompleted'] == 1,
      category: map['category'], // Ensure this is included
      priority: map['priority'], // Add this line
    );
  }
}
