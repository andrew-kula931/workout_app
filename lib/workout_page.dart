import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'add_workout.dart';

class WorkoutPage extends StatefulWidget {
  final Box workoutBox;
  const WorkoutPage({super.key, required this.workoutBox});

  @override
  State<WorkoutPage> createState() => _WorkoutPage();
}

class _WorkoutPage extends State<WorkoutPage> {
  late Box testBox;
  var workoutBox = Hive.box('Workout');

  //Testing String
  String testString = 'Test Hive';

  @override
  void initState() {
    super.initState();
  }

  List<Widget> workoutTile (Box box) {
    return box.values.map<Widget>((value) {
      return ListTile(
        title: Text(value.toString()),
        );
    }).toList();
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
              testBox.put('Workout', 'Upper Body');
              setState(() {
                testString = testBox.get('Workout');
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
                      return const AddWorkout();
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
          Flexible (
            child: ListView(
              children: workoutTile(workoutBox),
            ),
          ),
        ],
      ),
    );
  }
}