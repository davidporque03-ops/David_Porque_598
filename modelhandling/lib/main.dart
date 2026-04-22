import 'package:flutter/material.dart';
import 'package:modelhandling/screen/chart_screen.dart';
// import 'package:modelhandling/screen/student_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://jktrhjkzqnxpzluhswnr.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImprdHJoamt6cW54cHpsdWhzd25yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI1Njg4MjAsImV4cCI6MjA4ODE0NDgyMH0.6iR1FgNZy0hqOpq0x_7CNsBnhWgqIwmFYtRimBTT5VY",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FINAL EXAM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ChatPage(username: 'David Porque'),
    );
  }
}
