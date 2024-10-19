import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../workout_components/add_workout.dart';
import '../workout_components/workout_notes.dart';
import '../workout_components/edit_workout.dart';
import 'workout_archive.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPage();
}

class _WorkoutPage extends State<WorkoutPage> {
  late final Box _workoutBox;
  late final Box _workoutNotes;
  late final Box _workoutDocs;
  late List<String> worked;
  late List<String> notworked;

  //Setup for areas worked calculations
  Map<String, int> muscleGroups = {
    'upperChest': 0,
    'lowerChest': 0,
    'latissimusDorsi': 0,
    'rhomboid': 0,
    'trapezius': 0,
    'teres': 0,
    'erectorSpinae': 0,
    'biceps': 0,
    'triceps': 0,
    'deltoids': 0,
    'obliques': 0,
    'abs': 0,
    'hamstrings': 0,
    'gluteals': 0,
    'quadriceps': 0,
    'calves': 0,
  };

  @override
  void initState() {
    super.initState();
    _workoutBox = Hive.box('Workout');
    _workoutNotes = Hive.box('WorkoutNotes');
    _workoutDocs = Hive.box('WorkoutDoc');
    countAreas();
  }

  //Counts the worked areas
  void countAreas() {
    for (var i = 0; i < _workoutDocs.length; i++) {
      var obj = _workoutDocs.getAt(i);
      for (var area in obj.workAreas) {
       switch (area) {
        case 'Upper Chest':
          muscleGroups['upperChest'] = muscleGroups['upperChest']! + 1;
          break;
        case 'Lower Chest':
          muscleGroups['lowerChest'] = muscleGroups['lowerChest']! + 1;
          break;
        case 'Latissimus Dorsi':
          muscleGroups['latissimusDorsi'] = muscleGroups['latissimusDorsi']! + 1;
          break;
        case 'Rhomboid':
          muscleGroups['rhomboid'] = muscleGroups['rhomboid']! + 1;
          break;
        case 'Trapezius':
          muscleGroups['trapezius'] = muscleGroups['trapezius']! + 1;
          break;
        case 'Teres':
          muscleGroups['teres'] = muscleGroups['teres']! + 1;
          break;
        case 'Erector Spinae':
          muscleGroups['erectorSpinae'] = muscleGroups['erectorSpinae']! + 1;
          break;
        case 'Biceps':
          muscleGroups['biceps'] = muscleGroups['biceps']! + 1;
          break;
        case 'Triceps':
          muscleGroups['triceps'] = muscleGroups['triceps']! + 1;
          break;
        case 'Deltoids':
          muscleGroups['deltoids'] = muscleGroups['deltoids']! + 1;
          break;
        case 'Obliques':
          muscleGroups['obliques'] = muscleGroups['obliques']! + 1;
          break;
        case 'Abs':
          muscleGroups['abs'] = muscleGroups['abs']! + 1;
          break;
        case 'Hamstrings':
          muscleGroups['hamstrings'] = muscleGroups['hamstrings']! + 1;
          break;
        case 'Gluteals':
          muscleGroups['gluteals'] = muscleGroups['gluteals']! + 1;
          break;
        case 'Quadriceps':
          muscleGroups['quadriceps'] = muscleGroups['quadriceps']! + 1;
          break;
        case 'Calves':
          muscleGroups['calves'] = muscleGroups['calves']! + 1;
          break;
        default:
          break;
        }
      }
    }
    worked = muscleGroups.entries
      .where((entry) => entry.value > 0)
      .map((entry) => entry.key)
      .toList();
    notworked = muscleGroups.entries
      .where((entry) => entry.value == 0)
      .map((entry) => entry.key)
      .toList();
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
                    child: Text(worked.join(', ')),
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
                    child: Text(notworked.join(', ')),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutArchive()));
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
                  ).then((value) {
                    setState(() {});
                  });
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
                  ).then((value) {
                    setState(() {});
                  });
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
            child: ListView.builder(
              itemCount: _workoutBox.length,
              itemBuilder: (context, index) {
                var value = _workoutBox.getAt(index);
                return Padding(
                  padding: const EdgeInsets.only(left:20, right:20, bottom: 1),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return EditWorkout(workoutDb: _workoutBox, index: index, time: false);
                        },
                      ).then((value) { //This is how I dynamically update the tile
                        setState(() {});
                      });
                    },
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
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}