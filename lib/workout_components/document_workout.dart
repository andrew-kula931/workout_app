import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/workout_db.dart';

class DocumentWorkout extends StatefulWidget {
  final Box workoutDb;
  final int index;
  const DocumentWorkout({super.key, required this.workoutDb, required this.index});

  @override
  State<DocumentWorkout> createState() => _DocumentWorkoutState();
}

class _DocumentWorkoutState extends State<DocumentWorkout> {

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

// ignore: non_constant_identifier_names
final List<String> MUSCLE_GROUPS = [
    'Upper Chest', 'Lower Chest', 'Latissimus Dorsi', 'Rhomboid',
    'Trapezius', 'Teres', 'Erector Spinae', 'Biceps', 'Triceps',
    'Deltoids', 'Obliques', 'Abs', 'Hamstrings', 'Gluteals', 'Quadriceps',
    'Calves'
  ];
  String? dropDownValue;
  bool groupList = false;

  //Retrieving and later storing inputted values
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _workoutsController = TextEditingController();
  List<String> dropDownValues = [];

  Future<void> _initializeControllers() async {
    var box = Hive.box('Workout');
    var workoutData = box.getAt(widget.index);

    if(workoutData != null) {
      setState(() {
        _nameController.text = workoutData.name;
        _workoutsController.text = workoutData.workouts;
        dropDownValues = workoutData.workAreas ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return IntrinsicHeight(
      child: Container(
        width: screenWidth,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Add Workout', style: TextStyle(fontSize: 20)),
              ],
            ),

            //Name Row
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Name: '),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),

            //Exercises Row
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Exercises: '),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      controller: _workoutsController,
                      decoration: const InputDecoration(labelText: 'Excercises', border: OutlineInputBorder()),
                      maxLines: 5,
                      minLines: 1,
                    ),
                  ),
                ],
              ),
            ),

            //Muscle Groups worked
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Muscle Groups Worked: '),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        groupList = !groupList;
                      });
                    },
                    child: const Text('Muscles Worked'),
                  ),
                ],
              ),
            ),
            if(groupList)
              Padding(
                padding: const EdgeInsets.all(4),
                child: SizedBox(
                  width: 350,
                  height: 200,
                  child: ListView(
                    children: MUSCLE_GROUPS.map((String item) {
                      return CheckboxListTile(
                        title: Text(item),
                        value: dropDownValues.contains(item),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              dropDownValues.add(item);
                            } else {
                              dropDownValues.remove(item);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            
            //Update button
            ElevatedButton(
              onPressed: () async {
                var box = Hive.box('Workout');
                WorkoutDb data = WorkoutDb(
                  name: _nameController.text,
                  workouts: _workoutsController.text,
                  workAreas: dropDownValues,
                );
                await box.add(data);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}