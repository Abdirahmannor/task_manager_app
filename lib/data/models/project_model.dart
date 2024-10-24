class Project {
  final int? id;
  final String name;
  final String description;
  final String priority;
  final String status;
  final int duration; // Duration in days
  final DateTime startDate; // Start date
  final DateTime lastDate; // Last date calculated

  Project({
    this.id,
    required this.name,
    this.description = '',
    required this.priority,
    required this.status,
    required this.duration,
    required this.startDate,
    required this.lastDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'priority': priority,
      'status': status,
      'duration': duration,
      'startDate': startDate.toIso8601String(),
      'lastDate': lastDate.toIso8601String(),
    };
  }

  static Project fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      priority: map['priority'],
      status: map['status'],
      duration: map['duration'],
      startDate: DateTime.parse(map['startDate']),
      lastDate: DateTime.parse(map['lastDate']),
    );
  }
}
