import 'package:flutter/material.dart';
import 'package:flutter_micare/screen/rsvp_form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RSVP Form',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const RsvpForm(),
    );
  }
}
