import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'workout_components/add_workout.dart';
import 'workout_components/workout_notes.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPage();
}

class _WorkoutPage extends State<WorkoutPage> {
  late final Box _workoutBox;
  late final Box _workoutNotes;

  @override
  void initState() {
    super.initState();
    _workoutBox = Hive.box('Workout');
    _workoutNotes = Hive.box('WorkoutNotes');
  }

//List tile for the list of workouts created
  List<Widget> workoutTile (Box box) {
    return box.values.map<Widget>((value) {
      return Padding(
        padding: const EdgeInsets.only(left:20, right:20),
        child: ListTile(
        tileColor: Colors.amber,
        title: Text(value.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Workouts: ${value.workouts}'),
            Text('Work Areas: ${value.workAreas?.join(', ') ?? 'No Work Areas'}'),
          ],
        ),
        ),
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

          //Operation buttons
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
                      return AddWorkout(workoutBox: _workoutBox);
                    },
                  );
                },
                child: const Text('Add Workout'),
              ),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return WorkoutNotes(workoutNotes: _workoutNotes);
                    }
                  );
                },
                child: const Text('Workout Notes'),
              ),
            ],
          ),

          //List of workouts created
          Container(
            margin: const EdgeInsets.only(left: 20, top: 20),
            child: const Text('Workouts:', style: TextStyle(fontSize: 20))
          ),
          Flexible(
            child: ListView(
              children: workoutTile(_workoutBox),
            ),
          ),
        ],
      ),
    );
  }
}