import 'package:flutter/material.dart';

class SchoolManagementScreen extends StatelessWidget {
  const SchoolManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School Management'),
      ),
      body: Center(
        child: Text('Manage Exams and Results'),
      ),
    );
  }
}
