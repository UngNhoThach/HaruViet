import 'package:eco_app/data_local/models/task.dart';
import 'package:eco_app/data_local/task_database.dart';
import 'package:eco_app/page/add_task/add_task_page.dart';
import 'package:eco_app/page/add_task/task_title.dart';
import 'package:flutter/material.dart';

class TestSqlPage extends StatefulWidget {
  const TestSqlPage({super.key});

  @override
  State<TestSqlPage> createState() => _TestSqlPageState();
}

class _TestSqlPageState extends State<TestSqlPage> {
  bool isLoading = false;
  List<Task> tasks = [];

  Future<void> getAllTasks() async {
    setState(() => isLoading = true);

    tasks = (await TasksDatabase.instance.readAllTasks());

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    getAllTasks();
  }

  @override
  void dispose() {
    TasksDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks List'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildTasksList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddTaskScreen(),
            ),
          );

          getAllTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTasksList() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddTaskScreen(
                    task: task,
                  ),
                ),
              );

              getAllTasks();
            },
            child: TaskListTile(task: task));
      },
    );
  }
}
