import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'add_workout.dart';

void init() async {
  await Hive.initFlutter();
}

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPage();
}

class _WorkoutPage extends State<WorkoutPage> {
  late Box box;

  //Testing String
  String testString = 'Test Hive';

  @override
  void initState() {
    super.initState();
    openBox();
  }

  void openBox() async {
    box = await Hive.openBox('testBox'); //This is a test using Hive
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text('Workout'),
      ),
      body: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Just for testing
          ElevatedButton(
            onPressed: () {
              box.put('Workout', 'Upper Body');
              setState(() {
                testString = box.get('Workout');
              });
            },
            child: Text(testString),
          ),


          //Summary Section
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: const Text('Summary:', style: TextStyle(fontSize: 30)),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Areas Worked: '),
                  Container(
                    height: 50,
                    width: 400,
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: const Text('To Fill In'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Areas to Work: '),
                  Container(
                    height: 50,
                    width: 400,
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: const Text('To Fill In'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  //Fill in action here <========
                },
                child: const Text('Schedule Workout'),
              ),
              ElevatedButton(
                onPressed: () {
                  //Fill in action here <========
                },
                child: const Text('Document Workout'),
              ),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container (
                        height: 200,
                        child: const Center (
                          child: Text('Hello World'),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Add Workout'),
              ),
              ElevatedButton(
                onPressed: () {
                  //Fill in action here <========
                },
                child: const Text('Workout Notes'),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 20),
            child: const Text('Workouts:', style: TextStyle(fontSize: 20))
          ),
        ],
      ),
    );
  }
}