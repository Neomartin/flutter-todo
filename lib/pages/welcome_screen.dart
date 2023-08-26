import 'package:flutter/material.dart';
import 'package:todo/components/input_field.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Welcome to Paw Chat!!'),
              )),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    InputTextField(
                      label: 'Email',
                      hintText: 'Enter an email',
                      icon: const Icon(Icons.email),
                      onChanged: (value) {
                        print("Email $value");
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
                        print("PassGuord $value");
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
