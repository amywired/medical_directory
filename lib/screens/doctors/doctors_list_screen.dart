import 'package:flutter/material.dart';
import 'package:medical_directory/main.dart';
import 'package:medical_directory/Database/SqlDb.dart';
import 'add_doctor_screen.dart';

class DoctorsListScreen extends StatefulWidget {
  final String specialty;

  const DoctorsListScreen({super.key, required this.specialty});

  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  Sqldb sqlDb = Sqldb();
  List<Map<String, dynamic>> doctors = [];
  List<Map<String, dynamic>> filteredDoctors = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  // Fetch doctors from the SQLite database based on the selected specialty
  Future<void> fetchDoctors() async {
    // Read from the "Doctor" table defined in your SqlDb.dart
    List<Map<String, dynamic>> response = await sqlDb.readData(
        "SELECT * FROM Doctor WHERE specialty = '${widget.specialty}'"
    );

    setState(() {
      doctors = response;
      filteredDoctors = response;
      isLoading = false;
    });
  }

  // Search bar logic
  void filterSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredDoctors = doctors;
      } else {
        filteredDoctors = doctors
            .where((doc) => doc['name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color primaryMint = Color(0xFF70FFD8);
    final Color cardBg = isDark ? const Color(0xFF1C2523) : Colors.grey[100]!;
    final Color textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D1412) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.specialty,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: isDark ? primaryMint : Colors.black),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: primaryMint),
            onPressed: () => MyApp.of(context).toggleTheme(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: filterSearch,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: "Search doctor...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: isDark ? const Color(0xFF2C3633) : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: isDark ? Colors.white10 : Colors.black12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: isDark ? Colors.white10 : Colors.black12),
                ),
              ),
            ),
          ),

          // Doctors List
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator(color: primaryMint))
                : filteredDoctors.isEmpty
                ? Center(
              child: Text(
                "No doctors found for this specialty.",
                style: TextStyle(color: textColor),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doc = filteredDoctors[index];
                return Card(
                  color: cardBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF00BFA5).withOpacity(0.2),
                      child: const Icon(Icons.person, color: Color(0xFF00BFA5)),
                    ),
                    title: Text(
                      doc['name'],
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doc['specialty'], style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(doc['Location'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        )
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.phone, color: Colors.green),
                      onPressed: () {
                        // Can add phone launch logic here later using doc['Phone']
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF00BFA5),
        onPressed: () {
          // Navigate to the Add Doctor Screen your teammate made
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDoctorScreen()),
          ).then((value) {
            // Refresh the list when coming back from adding a doctor
            fetchDoctors();
          });
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}