class Task {
  String title;
  String description;
  String priority; // Alta, Media, Baja
  String status; // Pendiente, En progreso, Completada
  double progress; // Porcentaje de completado (0.0 a 1.0)

  Task({
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.progress,
  });
}
