import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/workout_db.dart';

class EditWorkout extends StatefulWidget {
  final Box workoutDb;
  final int index;
  final bool time;
  const EditWorkout({super.key,
  required this.workoutDb, 
  required this.index, 
  required this.time});

  @override
  State<EditWorkout> createState() => _EditWorkoutState();
}

class _EditWorkoutState extends State<EditWorkout> {
  final _formKey = GlobalKey<FormState>();

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
  final TextEditingController _dateTimeController = TextEditingController();

  //Sets the inital controller values
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

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateTimeController.text = picked.toString();
      });
    }
  }

  @override
  void dispose() {
    _dateTimeController.dispose();
    _nameController.dispose();
    _workoutsController.dispose();
    super.dispose();
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
            
            //Date Picker
            if(widget.time)
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _dateTimeController,
                  readOnly: true,
                  //Validates if it has been set
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please set date';
                    }
                    return null;
                  },
                  onTap: () => _selectDate(context),
                  decoration: const InputDecoration(hintText: 'Select Date'),
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Update button
                ElevatedButton(
                  onPressed: () async {
                    if (widget.time) {
                      if (_formKey.currentState!.validate()) {
                        var box = Hive.box('WorkoutDoc');
                        WorkoutDoc data = WorkoutDoc(
                          name: _nameController.text,
                          workouts: _workoutsController.text,
                          workAreas: dropDownValues,
                          day: DateTime.parse(_dateTimeController.text),
                        );
                        await box.add(data);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    } else {
                      var box = Hive.box('Workout');
                      var boxToChange = box.getAt(widget.index);
                      boxToChange.name = _nameController.text;
                      boxToChange.workouts = _workoutsController.text;
                      boxToChange.workAreas = dropDownValues;
                      boxToChange.save();
                      Navigator.pop(context);
                    }
                  },
                  child: Text(!widget.time ? "Update" : 'Add',), //Sets text conditionally
                ),

                //Delete Button, only shows if editing
                if(!widget.time)
                  ElevatedButton(
                    onPressed: () async {
                      var badBox = Hive.box('Workout');
                      badBox.deleteAt(widget.index);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    child: const Text('Delete'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}