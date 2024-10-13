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
  bool healthMenu = false;
  bool workoutMenu = false;
  bool orgMenu = false;
  bool funMenu = false;

  void _healthMenu() {
    setState(() {
      healthMenu = !healthMenu;
    });
  }

  void _workoutMenu() {
    setState(() {
      workoutMenu = !workoutMenu;
    });
  }

  void _orgMenu() {
    setState(() {
      orgMenu = !orgMenu;
    });
  }

  void _funMenu() {
    setState(() {
      funMenu = !funMenu;
    });
  }

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

        //Main page is the navagation row stacked on the main column
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                //The page options at the top of the main page
                Row (
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: _healthMenu,
                        child:Container(
                          width: screenWidth * .25,
                          height: 50,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: const Center(
                            child: Text('Heath'),
                          ),
                        ),
                      ),
                      if (healthMenu)
                        Container(
                          width: screenWidth * .25,
                          decoration: const BoxDecoration(color: Colors.green),
                          child: const Column (
                            children: [
                              Text("Update Calories"),
                              Text('View History'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: _workoutMenu,
                          child: Container(
                            width: screenWidth * .25,
                            height: 50,
                            decoration: const BoxDecoration(color: Colors.white),
                            child: const Center(
                              child: Text('Workout'),
                            ),
                          ),
                        ),
                        if (workoutMenu)
                          Container(
                            width: screenWidth * .25,
                            decoration: const BoxDecoration(color: Colors.green),
                            child: const Column (
                              children: [
                                Text("Update Workout Info"),
                                Text('View History'),
                                Text('Routine Planner'),
                              ],
                            )
                          ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: _orgMenu,
                          child: Container(
                            width: screenWidth * .25,
                            height: 50,
                            decoration: const BoxDecoration(color: Colors.white),
                            child: const Center(
                              child: Text('Organization'),
                            ),
                          ),
                        ),
                        if (orgMenu)
                          Container(
                            width: screenWidth * .25,
                            decoration: const BoxDecoration(color: Colors.green),
                            child: const Column (
                              children: [
                                Text("Edit/Add Events"),
                                Text('Calendar'),
                              ],
                            )
                          ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: _funMenu,
                          child: Container(
                            width: screenWidth * .25,
                            height: 50,
                            decoration: const BoxDecoration(color: Colors.white),
                            child: const Center(
                              child: Text('Fun'),
                            ),
                          ),
                        ),
                        if (funMenu)
                          Container(
                            width: screenWidth * .25,
                            decoration: const BoxDecoration(color: Colors.green),
                            child: const Column (
                              children: [
                                Text("Solitare"),
                                Text('Poker'),
                                Text('Random Wheel'),
                              ],
                            )
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}