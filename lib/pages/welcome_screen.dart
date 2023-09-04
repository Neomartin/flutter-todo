import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/components/button_widget.dart';
import 'package:todo/components/input_field.dart';
import 'package:todo/components/wave_widget.dart';
import 'package:todo/pages/todo_screen.dart';
import 'package:todo/utils/firebase_auth_error.dart';

import '../viewmodels/input_validators.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isEmailValid = false;
  bool isPasswordValid = false;
  String email = '';
  String password = '';
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: WaveWidgetTest()),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  InputTextField(
                    label: 'Email',
                    hintText: 'Enter an email',
                    icon: const Icon(Icons.email),
                    onChanged: (value) {
                      setState(() {
                        isEmailValid = isValidEmail(value);
                        email = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextField(
                    label: 'Password',
                    hintText: 'Enter a password',
                    icon: const Icon(Icons.lock),
                    onChanged: (value) {
                      setState(() {
                        isPasswordValid = value.length >= 6;
                        password = value;
                      });
                    },
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    label: 'Login',
                    onPressed: isEmailValid && isPasswordValid
                        ? () async {
                            try {
                              final localContext = context;
                              await auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                              Navigator.pushNamed(
                                  _scaffoldKey.currentContext!, TodoScreen.id);
                            } catch (e) {
                              if (e is FirebaseAuthException) {
                                String error = getErrorMessage(e);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(error),
                                  ),
                                );
                              }
                            }
                          }
                        : null,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    label: 'Sign Up',
                    outlineButton: true,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 40.0),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Text('¿Olvidaste tu contraseña?'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('¿No tienes cuenta?'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
