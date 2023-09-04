import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/todo_screen.dart';
import 'package:todo/pages/welcome_screen.dart';
import 'package:todo/shared/globals.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return kPrimaryDarkColor; // Active color
              }
              return Colors.grey[300]; // Inactive color
            }),
            checkColor: MaterialStateProperty.all(Colors.black),
          ),
        ),
        title: 'ToDo App',
        home: const WelcomeScreen(),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          TodoScreen.id: (context) => const TodoScreen(),
        });
  }
}
