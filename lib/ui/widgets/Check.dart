void _deleteProject(String projectId) {
  // Confirm deletion with the user
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Project"),
        content: const Text("Are you sure you want to delete this project?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog without deleting
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Deleting the project and updating the state
              setState(() {
                _projectManager.deleteProject(projectId); // Delete the project
                userProjects = _projectManager
                    .getAllProjects(); // Refresh the project list
              });
              // Show feedback to the user
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Project deleted successfully!'),
                  backgroundColor: AppTheme.sidebarSelectedColor,
                ),
              );
              Navigator.of(context).pop(); // Close the dialog after deletion
            },
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}
