import 'package:flutter/material.dart';

class AddWorkout extends StatefulWidget {
  const AddWorkout({super.key});

  @override
  State<AddWorkout> createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
    // ignore: non_constant_identifier_names
    final List<String> MUSCLE_GROUPS = [
      'Upper Chest', 'Lower Chest', 'Latissimus Dorsi', 'Rhomboid',
      'Trapezius', 'Teres', 'Erector Spinae', 'Biceps', 'Triceps',
      'Deltoids', 'Obliques', 'Abs', 'Hamstrings', 'Gluteals', 'Quadriceps',
      'Calves'
    ];
    String? dropDownValue;
    List<String> dropDownValues = [];
    bool groupList = false;

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
                  Container(
                    width: 350,
                    height: 50,
                    child: const TextField(
                      decoration: InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
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
                  Container(
                    width: 350,
                    child: const TextField(
                      decoration: InputDecoration(labelText: 'Excercises', border: OutlineInputBorder()),
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
                child: Container(
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
          ],
        ),
      ),
    );
  }
}