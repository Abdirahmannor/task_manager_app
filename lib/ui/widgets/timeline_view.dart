import 'package:flutter/material.dart';

class TimelineView extends StatelessWidget {
  const TimelineView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Timeline',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                _buildTimelineEntry(
                  time: '9:00 AM',
                  taskName: 'Team Meeting',
                  taskStatus: 'Working',
                  color: Colors.green,
                ),
                _buildTimelineEntry(
                  time: '10:30 AM',
                  taskName: 'Finance Web Page',
                  taskStatus: 'Pending',
                  color: Colors.orange,
                ),
                _buildTimelineEntry(
                  time: '12:00 PM',
                  taskName: 'Website Wireframe Design',
                  taskStatus: 'Completed',
                  color: Colors.blue,
                ),
                // More timeline entries can be added here
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineEntry({
    required String time,
    required String taskName,
    required String taskStatus,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              time,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Card(
              color: color,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      taskStatus,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
