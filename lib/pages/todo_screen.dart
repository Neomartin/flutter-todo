import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/components/add_taks.dart';
import 'package:todo/components/input_field.dart';
import 'package:todo/components/todo_list_item.dart';
import 'package:todo/shared/globals.dart';

import '../model/Todo.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});
  static const String id = 'todo_screen';

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List todos = [];
  String searchValue = '';
  @override
  void initState() {
    super.initState();
    getTodos();
  }

  void getTodos() async {
    await firestore
        .collection('todos')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          todos.add(doc.data());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kPrimaryDarkColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AddTaks(),
        ),
        backgroundColor: kPrimaryDarkColor,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(height: 70),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[800],
                    child: Icon(
                      Icons.list,
                      size: 70,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("My Tasks", style: kHeadingTextStyle),
                  ],
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("1 of 8", style: kSubheadingTextStyle),
            ],
          ),
          const SizedBox(height: 10),
          InputTextField(
            label: 'Search task',
            hintText: 'Enter a task',
            hintStyle: kHintTextStyle,
            fillColor: kPrimaryColorInput,
            icon: const Icon(Icons.search),
            onChanged: (value) {
              setState(() {
                searchValue = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                ),
              ),
              child: StreamBuilder(
                stream: firestore
                    .collection('todos')
                    .orderBy('date', descending: false)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<Todo> todos = [];
                  if (searchValue.length < 3) {
                    todos = snapshot.data!.docs
                        .map((doc) => Todo.fromDocument(doc))
                        .toList();
                  } else {
                    todos = snapshot.data!.docs
                        .map((doc) => Todo.fromDocument(doc))
                        .where((todo) =>
                            todo.title.toLowerCase().contains(searchValue) ||
                            todo.description
                                .toLowerCase()
                                .contains(searchValue))
                        .toList();
                  }
                  return ListTileTheme(
                    textColor: Colors.white,
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        return ConstrainedBox(
                            constraints: const BoxConstraints(
                              minHeight: 60,
                            ),
                            child: TodoListItem(todo: todos[index]));
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
