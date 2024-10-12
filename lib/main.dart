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

//First class displayed on starter page
class _WorkoutAppState extends State<WorkoutApp> {
  final _formKey = GlobalKey<FormState>();
  String workoutType = '';
  int duration = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Working Out'), 
      centerTitle: true,
      titleTextStyle: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.red,) ),
      body: Form(
        key: _formKey,

        //Main page column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            //The page options at the top of the main page
            Row (
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: screenWidth * .25,
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: const Center(
                    child: Text('Heath'),
                  ),
                ),
                Container(
                  width: screenWidth * .25,
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: const Center(
                    child: Text('Workout'),
                  ),
                ),
                Container(
                  width: screenWidth * .25,
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: const Center(
                    child: Text('Organization'),
                  ),
                ),
                Container(
                  width: screenWidth * .25,
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: const Center(
                    child: Text('Fun'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}