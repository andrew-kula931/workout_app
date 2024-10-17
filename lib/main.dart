import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'workout_page.dart';
import 'data/workout_db.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutDbAdapter());
  await Hive.openBox('Workout');

  await Hive.openBox('WorkoutNotes');

  runApp(const MyApp());
}
/*
void printBoxContents(Box box) {
  print('Box Name: ${box.name}');
  print('Box Length: ${box.length}');
  print('Box Keys: ${box.keys}');
  print('Box Values: ${box.values}');
}
*/
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
      appBar: AppBar(title: const Text('Working It Out'), 
      centerTitle: true,
      titleTextStyle: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.red,) ),
      body: Form(
        key: _formKey,

        //Main page is the navagation row stacked on the main column
        child: Stack(
          children: [

            //Main page
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //Top Info
                Container(
                  margin: const EdgeInsets.only(left: 40, top: 60),
                  child: const Text('This Week:', style: TextStyle(fontSize: 30)),
                ),

                //The Event bar
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  decoration: const BoxDecoration(color: Colors.teal),
                  child: const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Events', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),

                //The goals bar
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: const BoxDecoration(color: Colors.green),
                  child: const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Goals', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),

                //The workout bar
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: const BoxDecoration(color: Colors.teal),
                  child: const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Workouts', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),

                //Health Summary
                const Column(
                  children: [
                    Text('Health Summary', style: TextStyle(fontSize: 30)),

                    //Calories burned
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Calories burned this week: '),
                          Text('Fill in some value.'),
                        ],
                      ),
                    ),

                    //Calories consumed
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Calories consumed:  '),
                          Text('Fill in some value.'),
                        ],
                      ),
                    ),

                    //Next workout to do
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Next Workout: '),
                          Text('Fill in some value.'),
                        ],
                      ),
                    ),

                    //Underworked areas
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Underworked areas: '),
                          Text('Fill in some value.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            //Navigation Bar column
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
                          onLongPress: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutPage()));
                          },
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