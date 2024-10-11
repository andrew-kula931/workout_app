import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const WorkoutApp(title: 'Flutter Demo Home Page'),
    );
  }
}

class WorkoutApp extends StatefulWidget {
  const WorkoutApp({super.key, required this.title});

  final String title;

  @override
  State<WorkoutApp> createState() => _WorkoutAppState();
}

class _WorkoutAppState extends State<WorkoutApp> {
  final _formKey = GlobalKey<FormState>();
  String workoutType = '';
  int duration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Working Out')),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Workout Type'),
              onSaved: (value) {
                workoutType = value!;
              },
            ),
          ],
        ),
      ),
    );
  }
}