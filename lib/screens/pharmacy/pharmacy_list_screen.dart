// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:medical_directory/main.dart'; // Added to access the theme toggle

class PharmacyListScreen extends StatefulWidget {
  const PharmacyListScreen({super.key});

  @override
  State<PharmacyListScreen> createState() => _PharmacyListScreenState();
}

class _PharmacyListScreenState extends State<PharmacyListScreen> {
  List<Map<String, dynamic>> pharmacies = [];
  List<Map<String, dynamic>> filteredPharmacies = [];
  bool isLoading = true;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    loadFakeData();

    // تحديث تلقائي
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      loadFakeData();
    });
  }

  // بيانات مؤقتة
  void loadFakeData() {
    List<Map<String, dynamic>> data = [
      {
        "name": "Pharmacy Central",
        "city": "M'sila",
        "location": "Centre Ville",
        "phone": "0555555555"
      },
      {
        "name": "Pharma Plus",
        "city": "Algiers",
        "location": "Bab Ezzouar",
        "phone": "0666666666"
      },
      {
        "name": "Green Pharmacy",
        "city": "Oran",
        "location": "Hai Sabah",
        "phone": "0777777777"
      },
    ];

    if (mounted) {
      setState(() {
        pharmacies = data;
        filteredPharmacies = data;
        isLoading = false;
      });
    }
  }

  // Search
  void filterSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPharmacies = pharmacies;
      } else {
        filteredPharmacies = pharmacies.where((pharmacy) {
          return (pharmacy['name'] ?? '')
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Unified App Colors
    const Color primaryMint = Color(0xFF00BFA5);
    final Color textColorMain = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D1412) : Colors.white,
      appBar: AppBar(
        title: Text("Pharmacies", style: TextStyle(color: textColorMain, fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryMint),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // Added Dark/Light Mode Toggle
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: primaryMint),
            onPressed: () => MyApp.of(context).toggleTheme(),
          ),
        ],
      ),

      body: Column(
        children: [
          // 🔍 Search
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: filterSearch,
              style: TextStyle(color: textColorMain),
              decoration: InputDecoration(
                hintText: "Search pharmacy...",
                hintStyle: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                prefixIcon: const Icon(Icons.search, color: primaryMint),
                filled: true,
                fillColor: isDark ? const Color(0xFF2C3633) : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 📋 LIST
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator(color: primaryMint))
                : filteredPharmacies.isEmpty
                ? Center(child: Text("No pharmacies found", style: TextStyle(color: textColorMain)))
                : ListView.builder(
              itemCount: filteredPharmacies.length,
              itemBuilder: (context, index) {
                final pharmacy = filteredPharmacies[index];

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1C2523) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
                    boxShadow: [
                      if (!isDark)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        )
                    ],
                  ),
                  child: Row(
                    children: [
                      // 🟢 Icon
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: primaryMint.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.local_pharmacy, color: primaryMint),
                      ),

                      const SizedBox(width: 16),

                      // 📄 Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pharmacy['name'] ?? '',
                              style: TextStyle(
                                  color: textColorMain,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),

                            Text(
                              pharmacy['city'] ?? '',
                              style: const TextStyle(color: Colors.grey),
                            ),

                            const SizedBox(height: 5),

                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  pharmacy['location'] ?? '',
                                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // 📞 Call Button
                      IconButton(
                        icon: const Icon(Icons.phone, color: primaryMint),
                        onPressed: () {
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}