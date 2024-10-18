import 'package:hive/hive.dart';
import 'session_manager.dart';

class ProjectManager {
  final _projectsBox = Hive.box('projectsBox');
  final SessionManager _sessionManager = SessionManager();

  String? _getCurrentUserEmail() {
    return _sessionManager.getUserEmail();
  }

  // Save Project
  void saveProject(String projectId, Map<String, dynamic> projectData) {
    final userEmail = _getCurrentUserEmail();
    if (userEmail != null) {
      final projectKey = '${userEmail}_$projectId';
      _projectsBox.put(projectKey, projectData);
    }
  }

  // Get Project
  Map<String, dynamic>? getProject(String projectId) {
    final userEmail = _getCurrentUserEmail();
    if (userEmail != null) {
      final projectKey = '${userEmail}_$projectId';
      return _projectsBox.get(projectKey);
    }
    return null;
  }

  // Get All Projects for the Current User
  List<Map<String, dynamic>> getAllProjects() {
    final userEmail = _getCurrentUserEmail();
    if (userEmail != null) {
      final userProjects = _projectsBox.keys
          .where((key) => key.startsWith(userEmail))
          .map((key) {
        final dynamic project = _projectsBox.get(key);
        if (project is Map) {
          return project.map((key, value) => MapEntry(key.toString(), value));
        } else {
          return <String,
              dynamic>{}; // return empty map if the value is not a map
        }
      }).toList();
      return userProjects;
    }
    return [];
  }

  // Delete Project
  void deleteProject(String projectId) {
    final userEmail = _getCurrentUserEmail();
    if (userEmail != null) {
      final projectKey = '${userEmail}_$projectId';
      print('Deleting project with key: $projectKey'); // Debugging
      _projectsBox.delete(projectKey);
    }
  }
}
