import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../utills/project_manager.dart';
import '../../widgets/custom_title_bar.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});
  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final ProjectManager _projectManager = ProjectManager();
  late List<Map<String, dynamic>> userProjects;
  List<Map<String, dynamic>> filteredProjects = [];
  String activeTab = 'Projects'; // Declare activeTab to track the active tab
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'All'; // Default filter value

  final List<String> _statuses = ['All', 'Active', 'Completed', 'On Hold'];

  @override
  void initState() {
    super.initState();
    userProjects = _projectManager.getAllProjects();
    _initializeProjectIds();
    _searchController.addListener(_filterProjects);
    filteredProjects = List.from(userProjects); // Initial display
  }

  void _initializeProjectIds() {
    for (var project in userProjects) {
      if (project['id'] == null || project['id'] == 'Unknown ID') {
        project['id'] = DateTime.now().millisecondsSinceEpoch.toString();
        _projectManager.saveProject(project['id'], project);
      }
    }
  }

  void _filterProjects() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredProjects = userProjects.where((project) {
        final title = (project['title'] ?? '').toLowerCase();
        final description = (project['description'] ?? '').toLowerCase();
        final status = (project['status'] ?? 'Active').toLowerCase();
        // Example line 60

        // Apply status filtering if not "All"
        bool matchesStatus =
            _selectedStatus == 'All' || status == _selectedStatus.toLowerCase();

        return (title.contains(query) || description.contains(query)) &&
            matchesStatus;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _createNewProject() {
    // Existing create project code...
  }

  void _editProject(String projectId) {
    // Existing edit project code...
  }

  void _deleteProject(String projectId) {
    // Existing delete project code...
  }

// Example line 140: Add this new method above _buildProjectList
  Widget _buildSummarySection() {
    int totalProjects = userProjects.length;
    int activeProjects =
        userProjects.where((project) => project['status'] == 'Active').length;
    int completedProjects = userProjects
        .where((project) => project['status'] == 'Completed')
        .length;
    int onHoldProjects =
        userProjects.where((project) => project['status'] == 'On Hold').length;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSummaryCard('Total Projects', totalProjects, Icons.folder),
          _buildSummaryCard('Active', activeProjects, Icons.play_circle_fill),
          _buildSummaryCard('Completed', completedProjects, Icons.check_circle),
          _buildSummaryCard(
              'On Hold', onHoldProjects, Icons.pause_circle_filled),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, int count, IconData icon) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30, color: AppTheme.sidebarSelectedColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: AppTheme.textColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$count',
              style: const TextStyle(
                color: AppTheme.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Example line 155
  Widget _buildProjectList() {
    return filteredProjects.isEmpty
        ? const Center(
            child: Text(
              'No projects found. Start by creating a new project!',
              style: TextStyle(
                fontSize: 18,
                color: AppTheme.textColor,
              ),
            ),
          )
        : ListView.builder(
            itemCount: filteredProjects.length,
            itemBuilder: (context, index) {
              final project = filteredProjects[index];
              final projectId = project['id'] ?? 'Unknown ID';
              final projectStatus = project['status'] ?? 'Active';

              // Define the color for the status indicator based on project status
              Color statusColor;
              switch (projectStatus) {
                case 'Active':
                  statusColor = Colors.green;
                  break;
                case 'Completed':
                  statusColor = Colors.blue;
                  break;
                case 'On Hold':
                  statusColor = Colors.orange;
                  break;
                case 'Overdue':
                  statusColor = Colors.red;
                  break;
                default:
                  statusColor = Colors.grey;
              }

              return Card(
                color: Theme.of(context).cardColor,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: statusColor,
                    radius: 8,
                  ),
                  title: Text(
                    project['title'] ?? 'Unnamed Project',
                    style: const TextStyle(color: AppTheme.textColor),
                  ),
                  subtitle: Text(
                    'ID: $projectId\n${project['description'] ?? 'No description available'}',
                    style: const TextStyle(color: AppTheme.textColor),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editProject(projectId),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteProject(projectId),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  // Example line 195: Update the Expanded child section in the build method
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Row(
        children: [
          // SidebarDrawer code...
          Expanded(
            child: Column(
              children: [
                const CustomTitleBar(showIcons: true),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search Projects...',
                            hintStyle:
                                const TextStyle(color: AppTheme.textColor),
                            prefixIcon: Icon(
                              Icons.search,
                              color: isDarkMode
                                  ? AppTheme.darkSidebarIconColor
                                  : AppTheme.lightsidebarIconColor,
                            ),
                            filled: true,
                            fillColor: Theme.of(context).cardColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      DropdownButton<String>(
                        value: _selectedStatus,
                        dropdownColor: Theme.of(context).cardColor,
                        style: const TextStyle(color: AppTheme.textColor),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedStatus = newValue!;
                            _filterProjects();
                          });
                        },
                        items: _statuses
                            .map<DropdownMenuItem<String>>((String status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                _buildSummarySection(), // Add the summary section here
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildProjectList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDarkMode
            ? AppTheme.darkSidebarIconColor
            : AppTheme.lightsidebarIconColor,
        onPressed: _createNewProject,
        child: const Icon(Icons.add, color: AppTheme.darkSidebarTextColor),
      ),
    );
  }
}
