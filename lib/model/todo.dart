import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id;
  String title;
  String description;
  DateTime date;
  DateTime endDate;
  String status;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.endDate,
    required this.status,
  });

  factory Todo.fromDocument(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    Timestamp timestamp = data['date'];
    Timestamp timestampEndDate = data['endDate'];
    DateTime dateTime = timestamp.toDate();
    DateTime dateTimeEndDate = timestampEndDate.toDate();
    return Todo(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: dateTime,
      endDate: dateTimeEndDate,
      status: data['status'] ?? '',
    );
  }
}
