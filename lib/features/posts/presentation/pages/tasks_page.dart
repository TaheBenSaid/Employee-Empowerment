import 'dart:math';

import 'package:flutter/material.dart';

class Task {
  final String name;
  final String description;
  final String details;

  Task({
    required this.name,
    required this.description,
    required this.details,
  });
}

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<Task> tasks = [
    Task(
      name: 'Complete Project Proposal',
      description: 'Review project requirements and create a detailed proposal.',
      details: 'The proposal should include a project timeline, deliverables, and cost estimation.',
    ),
    Task(
      name: 'Prepare Presentation',
      description: 'Create a compelling presentation for the upcoming meeting.',
      details: 'Include key points, visual aids, and supporting data.',
    ),
    Task(
      name: 'Write Blog Post',
      description: 'Write an informative blog post on a relevant topic.',
      details: 'Research the subject, outline the post, and start writing the content.',
    ),
    Task(
      name: 'Develop Mobile App',
      description: 'Design and develop a mobile application with user-friendly features.',
      details: 'Implement UI design, integrate APIs, and perform thorough testing.',
    ),
    Task(
      name: 'Organize Team Meeting',
      description: 'Schedule and conduct a team meeting to discuss project updates.',
      details: 'Prepare an agenda, share important updates, and address team concerns.',
    ),
    Task(
      name: 'Create Marketing Campaign',
      description: 'Plan and execute a marketing campaign to promote the product.',
      details: 'Identify target audience, select marketing channels, and monitor campaign performance.',
    ),
    Task(
      name: 'Conduct User Research',
      description: 'Gather user feedback and insights to enhance the product usability.',
      details: 'Create surveys, conduct interviews, and analyze user behavior.',
    ),
    Task(
      name: 'Review Codebase',
      description: 'Perform code review to ensure code quality and adherence to coding standards.',
      details: 'Identify bugs, suggest improvements, and provide constructive feedback.',
    ),
    Task(
      name: 'Optimize Website Performance',
      description: 'Optimize website speed and performance for better user experience.',
      details: 'Analyze website performance metrics, optimize images, and implement caching strategies.',
    ),
    Task(
      name: 'Create Training Materials',
      description: 'Develop training materials for new employees on company policies and procedures.',
      details: 'Design slides, create informative content, and include interactive elements.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              title: Text(
                task.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(task.description),
              onTap: () => _showTaskDetails(task),
            ),
          );
        },
      ),
    );
  }


  void _showTaskDetails(Task task) {
    showDialog(
      context: context,
      builder: (context) {
        final deadlineRespect = Random().nextInt(6); // Random score out of 5
        final perfection = Random().nextInt(6); // Random score out of 5
        final discipline = Random().nextInt(6); // Random score out of 5
        final totalScore = deadlineRespect + perfection + discipline;

        return AlertDialog(
          title: Text(
            task.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCriteriaRow('Deadline Respect', deadlineRespect),
                _buildCriteriaRow('Perfection', perfection),
                _buildCriteriaRow('Discipline', discipline),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Total Score: $totalScore / 15',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCriteriaRow(String criteria, int score) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(criteria),
          ),
          Expanded(
            child: Text(
              score.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }


}
