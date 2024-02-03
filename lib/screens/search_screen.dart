import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/screens/filter_screen.dart';
import '../model/internship.dart';
import '../widgets/internship_card.dart';
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final String apiUrl = 'https://internshala.com/flutter_hiring/search';
  List<InternshipDetails> internships = [];
  List<InternshipDetails> filteredInternships = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final internshipDetailsList = jsonData['internships_meta'];

      List<InternshipDetails> tempInternships = [];
      internshipDetailsList.forEach((key, value) {
        tempInternships.add(InternshipDetails.fromJson(key, value));
      });

      setState(() {
        internships = tempInternships;
        filteredInternships =
            internships; // Initialize filteredInternships with all internships initially
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void filterInternships(String query) {
    setState(() {
      filteredInternships = internships
          .where((internship) =>
              internship.jobTitle.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _navigateToFilterScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterScreen(internships: internships),
      ),
    );

    if (result != null && result is List<InternshipDetails>) {
      setState(() {
        filteredInternships = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'Internships',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              //_showFilterDialog();
              _navigateToFilterScreen();
            },
            icon: const Icon(
              Icons.filter_alt_outlined,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                // Call a method to filter internships based on job title
                filterInternships(value);
              },
              decoration: const InputDecoration(
                hintText: 'Search by Job Title',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: internships.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredInternships.length,
                    itemBuilder: (context, index) {
                      return InternshipCard(
                          internship: filteredInternships[index]);
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}
