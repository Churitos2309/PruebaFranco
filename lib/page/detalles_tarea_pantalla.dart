import 'package:flutter/material.dart';
import 'package:tareas_prueba_flutter/model/tarea_model.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late double _progress;

  @override
  void initState() {
    super.initState();
    _progress = widget.task.progress;  // Inicializa el progreso con el valor actual de la tarea
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Descripción: ${widget.task.description}"),
            Text("Prioridad: ${widget.task.priority}"),
            Text("Estado: ${widget.task.status}"),
            SizedBox(height: 16),
            // Slider para modificar el progreso
            Text("Progreso: ${(100 * _progress).toStringAsFixed(0)}%"),
            Slider(
              value: _progress,
              min: 0.0,
              max: 1.0,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  _progress = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Actualizar el progreso de la tarea
                widget.task.progress = _progress;
                // Regresar la tarea actualizada a la pantalla principal
                Navigator.pop(context, widget.task);
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
