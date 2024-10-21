import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../workout_components/workout_list.dart';
import '../workout_components/schedule_workout.dart';

class RoutinePlanner extends StatefulWidget{
  const RoutinePlanner({super.key});

  @override
  State<RoutinePlanner> createState() => _RoutinePlannerState();
}

class _RoutinePlannerState extends State<RoutinePlanner> {
  late final Box workoutList;
  late final Box scheduleBox;

  @override
  void initState() {
    super.initState();
    workoutList = Hive.box('Workout');
    scheduleBox = Hive.box('WorkoutSchedule');
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  Future<void> _getWorkout() async {
    final result = await showModalBottomSheet<int>(
      context: context,
      builder: (context) {
        return WorkoutList(workoutList: workoutList);
      }
    );
    if (result != null) {
      showModalBottomSheet(
        // ignore: use_build_context_synchronously
        context: context, 
        builder: (context) {
          return PlanWorkout(index: result);
        }
      ).then((value) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<DateTime> weekDays = List.generate(7, (index) => now.add(Duration(days: index)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Routine Planner')
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () {
                _getWorkout();
              },
              child: const Text('Schedule Workout'),
            )
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height * .8),
            child: ListView.builder(
              itemCount: weekDays.length,
              itemBuilder: (context, index) {
                DateTime day = weekDays[index];
                return ListTile(
                  title: Text('${day.month}/${day.day} - ${_getWeekdayName(day.weekday)}'),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}