import 'package:flutter/material.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});
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
                  //Fill in action here <========
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