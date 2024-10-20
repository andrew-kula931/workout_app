import 'package:flutter/material.dart';

class RoutinePlanner extends StatefulWidget{
  const RoutinePlanner({super.key});

  @override
  State<RoutinePlanner> createState() => _RoutinePlannerState();
}

class _RoutinePlannerState extends State<RoutinePlanner> {

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
                //Fill in
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