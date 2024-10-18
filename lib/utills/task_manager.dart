import 'package:hive/hive.dart';
import 'session_manager.dart';

class TaskManager {
  final _tasksBox = Hive.box('tasksBox');
  final SessionManager _sessionManager = SessionManager();

  String? _getCurrentUserEmail() {
    return _sessionManager.getUserEmail();
  }

  // Save Task
  void saveTask(
      String projectId, String taskId, Map<String, dynamic> taskData) {
    final userEmail = _getCurrentUserEmail();
    if (userEmail != null) {
      final taskKey = '\${userEmail}_\${projectId}_\${taskId}';
      _tasksBox.put(taskKey, taskData);
    }
  }

  // Get Task
  Map<String, dynamic>? getTask(String projectId, String taskId) {
    final userEmail = _getCurrentUserEmail();
    if (userEmail != null) {
      final taskKey = '\${userEmail}_\${projectId}_\${taskId}';
      return _tasksBox.get(taskKey);
    }
    return null;
  }

  // Get All Tasks for a Specific Project
  List<Map<String, dynamic>> getAllTasks(String projectId) {
    final userEmail = _getCurrentUserEmail();
    if (userEmail != null) {
      final userTasks = _tasksBox.keys
          .where((key) => key.startsWith('\${userEmail}_\${projectId}_'))
          .map((key) => _tasksBox.get(key) as Map<String, dynamic>)
          .toList();
      return userTasks;
    }
    return [];
  }

  // Delete Task
  void deleteTask(String projectId, String taskId) {
    final userEmail = _getCurrentUserEmail();
    if (userEmail != null) {
      final taskKey = '\${userEmail}_\${projectId}_\${taskId}';
      _tasksBox.delete(taskKey);
    }
  }
}
