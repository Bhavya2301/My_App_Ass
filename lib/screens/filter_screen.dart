import 'package:flutter/material.dart';
import '../model/internship.dart';

class FilterScreen extends StatefulWidget {
  final List<InternshipDetails> internships;

  const FilterScreen({Key? key, required this.internships}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  late List<InternshipDetails> filteredInternships;

  @override
  void initState() {
    super.initState();
    filteredInternships =
        List.from(widget.internships); // Initialize with the original list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'Filter Internships',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: jobTitleController,
              decoration: const InputDecoration(
                label: Text(
                  "Job Title",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                label: Text(
                  "City",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(
                label: Text(
                  "Duration",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  // Call a method to apply filters and update the list
                  _applyFilters();
                  Navigator.pop(context,
                      filteredInternships); // Pass the filtered list back
                },
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilters() {
    String city = cityController.text.toLowerCase();
    String duration = durationController.text.toLowerCase();
    String jobTitle = jobTitleController.text.toLowerCase();

    setState(() {
      filteredInternships = widget.internships.where((internship) {
        bool cityMatches = city.isEmpty ||
            internship.location.any((loc) => loc.toLowerCase().contains(city));
        bool durationMatches = duration.isEmpty ||
            internship.duration.toLowerCase().contains(duration);
        bool jobTitleMatches = jobTitle.isEmpty ||
            internship.jobTitle.toLowerCase().contains(jobTitle);

        return cityMatches && durationMatches && jobTitleMatches;
      }).toList();
    });
  }
}
