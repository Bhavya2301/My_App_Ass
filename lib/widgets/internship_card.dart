import 'package:flutter/material.dart';
import '../model/internship.dart';

class InternshipCard extends StatelessWidget {
  final InternshipDetails internship;

  const InternshipCard({super.key, required this.internship});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0.8,
      margin: const EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              internship.jobTitle,
              style: const TextStyle(color: Colors.blue, fontSize: 20.0),
            ),
            Text('Location: ${internship.location.join(', ')}'),
            Text('Salary: ${internship.salary}'),
            Text('Duration: ${internship.duration}'),
          ],
        ),
      ),
    );
  }
}