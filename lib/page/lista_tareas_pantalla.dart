import 'package:flutter/material.dart';
import 'package:tareas_prueba_flutter/model/tarea_model.dart';
import 'package:tareas_prueba_flutter/page/detalles_tarea_pantalla.dart';
import 'package:tareas_prueba_flutter/page/nueva_tarea_pantalla.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> tasks = [
    Task(
        title: "Tarea 1",
        description: "Descripción",
        priority: "Alta",
        status: "Pendiente",
        progress: 0.2),
    Task(
        title: "Tarea 2",
        description: "Descripción",
        priority: "Media",
        status: "En progreso",
        progress: 0.5),
    // Otras tareas...
  ];
  // Método para añadir nuevas tareas
  void _addNewTask(Task newTask) {
    setState(() {
      tasks.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestor de Tareas"),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            child: ListTile(
              title: Text(task.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Prioridad: ${task.priority}"),
                  Text("Estado: ${task.status}"),
                  LinearProgressIndicator(value: task.progress),
                ],
              ),
              onTap: () async {
                // Navegar a la pantalla de detalles y esperar por el resultado
                final updatedTask = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailScreen(task: task),
                  ),
                );

                // Si la tarea fue actualizada, reflejar los cambios en la lista
                if (updatedTask != null) {
                  setState(() {
                    tasks[index] = updatedTask;
                  });
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navegar a la pantalla para añadir una nueva tarea
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTaskScreen()),
          );

          if (newTask != null) {
            _addNewTask(newTask);
          }
        },
        child: Icon(Icons.add),
        tooltip: 'Añadir Tarea',
      ),
    );
  }
}
