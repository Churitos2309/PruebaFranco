import 'package:flutter/material.dart';
import 'package:tareas_prueba_flutter/model/tarea_model.dart';

class NewTaskScreen extends StatefulWidget {
  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _priority = 'Media';  // Valor por defecto
  String _status = 'Pendiente';  // Valor por defecto
  double _progress = 0.0;  // Progreso inicial

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nueva Tarea"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción'),
                onSaved: (value) => _description = value!,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Prioridad'),
                value: _priority,
                items: ['Alta', 'Media', 'Baja'].map((priority) {
                  return DropdownMenuItem<String>(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Estado'),
                value: _status,
                items: ['Pendiente', 'En progreso', 'Completada'].map((status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),
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
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Task newTask = Task(
                      title: _title,
                      description: _description,
                      priority: _priority,
                      status: _status,
                      progress: _progress,
                    );
                    Navigator.pop(context, newTask);
                  }
                },
                child: Text('Añadir Tarea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
