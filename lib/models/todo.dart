class Todo {
  Todo({
    required this.title,
    required this.date,
  });

  String title;
  DateTime date;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'datetime': date.toIso8601String(),
    };
  }
}
