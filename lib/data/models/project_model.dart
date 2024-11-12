class Project {
  int? id;
  String name;
  String description;
  String category;
  String status;
  String priority;
  int duration;
  String startDate;
  String lastDate;
  List<String> checklist;

  Project({
    this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.status,
    required this.priority,
    required this.duration,
    required this.startDate,
    required this.lastDate,
    required this.checklist,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'status': status,
      'priority': priority,
      'duration': duration,
      'startDate': startDate,
      'lastDate': lastDate,
      'checklist': checklist.join(','),
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      category: map['category'],
      status: map['status'],
      priority: map['priority'],
      duration: map['duration'],
      startDate: map['startDate'],
      lastDate: map['lastDate'],
      checklist: map['checklist']?.split(',') ?? [],
    );
  }
}
