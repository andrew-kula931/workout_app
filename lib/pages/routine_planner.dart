import 'package:flutter/material.dart';

class RoutinePlanner extends StatefulWidget{
  const RoutinePlanner({super.key});

  @override
  State<RoutinePlanner> createState() => _RoutinePlannerState();
}

class _RoutinePlannerState extends State<RoutinePlanner> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routine Planner')
      ),
      body: const Column(
        children: [
          Text('Hello World'),
        ],
      )
    );
  }
}