import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/Todo.dart';
import '../shared/globals.dart';
import 'add_taks.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  const TodoListItem({required this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Theme(
      data: ThemeData.dark().copyWith(
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return kPrimaryColor; // Active color
            }
            return Colors.grey[300]; // Inactive color
          }),
          checkColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: todo.status == 'done' ? true : false,
                onChanged: (value) async {
                  try {
                    final newStatus = await firestore
                        .collection('todos')
                        .doc(todo.id)
                        .update({
                      'status': value == true ? 'done' : 'pending',
                      'endDate': Timestamp.now(),
                    });
                    String text = value! ? 'Task completed' : 'Task pending';
                    Color color =
                        value ? Colors.lightGreenAccent : Colors.orange;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Center(
                          child: Text(
                            text,
                            style: TextStyle(color: color),
                          ),
                        ),
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        todo.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        todo.description,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) => showDialog(
                  context: context,
                  builder: (BuildContext context) => AddTaks(todo: value),
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    value: todo,
                    child: const Text(
                      'Edit',
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 1.0,
            color: Colors.white24,
          )
        ],
      ),
    );
  }
}
