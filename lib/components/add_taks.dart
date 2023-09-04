import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/Todo.dart';
import '../shared/globals.dart';
import 'button_widget.dart';
import 'input_field.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class AddTaks extends StatelessWidget {
  final Todo? todo;
  AddTaks({this.todo, super.key});
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final id = todo?.id ?? '';
    final TextEditingController title =
        TextEditingController(text: todo?.title ?? '');
    final TextEditingController description =
        TextEditingController(text: todo?.description ?? '');
    final TextEditingController dateController = TextEditingController(
        text: todo?.date != null
            ? DateFormat('dd-MM-yyyy').format(todo!.date)
            : '');
    final TextEditingController endDateController = TextEditingController(
        text: todo?.endDate != null
            ? DateFormat('dd-MM-yyyy').format(todo!.endDate)
            : '');
    final localContext = context;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add a new task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryDarkColor,
              ),
            ),
            const SizedBox(height: 20),
            InputTextField(
              controller: title,
              label: 'Title',
              hintText: 'Enter a title',
              onChanged: (value) {},
            ),
            const SizedBox(height: 12),
            InputTextField(
              controller: description,
              label: 'Description',
              hintText: 'Enter a description',
              maxLines: 3,
              onChanged: (value) {},
            ),
            const SizedBox(height: 12),
            InputTextField(
                controller: dateController,
                label: 'Date',
                hintText: 'DD-MM-YYYY',
                icon: const Icon(Icons.calendar_today),
                onChanged: (value) {},
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: dateController.text.isNotEmpty
                        ? DateFormat('dd-MM-yyyy').parse(dateController.text)
                        : DateTime.now(),
                    firstDate: DateTime(2015),
                    lastDate: DateTime(2025),
                  );
                  if (pickedDate != null &&
                      pickedDate.toString() != dateController.text) {
                    endDateController.text = pickedDate.toString();
                    dateController.text =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                  }
                }),
            const SizedBox(height: 12),
            ButtonWidget(
              onPressed: () async {
                try {
                  id.isNotEmpty
                      ? await firestore
                          .collection('todos')
                          .doc(todo!.id)
                          .update({
                          'title': title.text,
                          'description': description.text,
                          'date': DateFormat('dd-MM-yyyy')
                              .parse(dateController.text),
                          'status': todo?.status,
                          'endDate': DateFormat('dd-MM-yyyy')
                              .parse(endDateController.text),
                        })
                      : await firestore.collection('todos').add({
                          'title': title.text,
                          'description': description.text,
                          'date': DateFormat('dd-MM-yyyy')
                              .parse(dateController.text),
                          'status': 'pending',
                          'endDate': DateFormat('dd-MM-yyyy')
                              .parse(endDateController.text),
                        });
                  Navigator.pop(_scaffoldKey.currentContext!);
                } catch (e) {
                  print(e);
                }
              },
              label: 'Add',
            ),
          ],
        ),
      ),
    );
  }
}
