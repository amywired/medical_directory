import 'package:flutter/material.dart';

const Color primaryMint = Color(0xFF70FFD8);

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({super.key});

  @override
  State<HospitalScreen> createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  String selectedFilter = "All";
  String searchQuery = "";

  final List<Map<String, dynamic>> hospitals = const [
    {
      "name": "City Hospital",
      "type": "General",
      "rating": 4.5,
      "reviews": 320,
      "distance": "1.2 km",
      "image": "assets/h1.png"
    },
    {
      "name": "Al Noor Hospital",
      "type": "Specialized",
      "rating": 4.7,
      "reviews": 154,
      "distance": "2.8 km",
      "image": "assets/h2.png"
    },
    {
      "name": "Health Care Hospital",
      "type": "General",
      "rating": 4.3,
      "reviews": 210,
      "distance": "3.6 km",
      "image": "assets/h3.png"
    },
    {
      "name": "Life Medical Center",
      "type": "Specialized",
      "rating": 4.6,
      "reviews": 98,
      "distance": "4.1 km",
      "image": "assets/h4.png"
    },
    {
      "name": "Ayah Clinic Hospital",
      "type": "General",
      "rating": 4.2,
      "reviews": 76,
      "distance": "4.5 km",
      "image": "assets/h5.png"
    },
  ];

  List<Map<String, dynamic>> get filteredHospitals {
    return hospitals.where((h) {
      final matchFilter = selectedFilter == "All" ||
          h["type"] == selectedFilter ||
          (selectedFilter == "Near Me" && h["distance"] == "1.2 km");

      final matchSearch =
          h["name"].toLowerCase().contains(searchQuery.toLowerCase());

      return matchFilter && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D1412) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Hospitals"),
        titleTextStyle: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primaryMint),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLandscape ? _buildLandscape(isDark) : _buildPortrait(isDark),
    );
  }

  // =========================
  // 📱 PORTRAIT
  // =========================
  Widget _buildPortrait(bool isDark) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSearch(isDark),
              const SizedBox(height: 15),
              _buildFilters(isHorizontal: true),
            ],
          ),
        ),
        Expanded(child: _buildList()),
      ],
    );
  }

  // =========================
  // 🖥️ LANDSCAPE (FIXED UI)
  // =========================
  Widget _buildLandscape(bool isDark) {
    return Row(
      children: [
        Container(
          width: 260,
          padding: const EdgeInsets.all(16),
          color: isDark ? const Color(0xFF1C2523) : Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearch(isDark),
              const SizedBox(height: 20),
              _buildFilters(isHorizontal: false), // 🔥 FIX HERE
            ],
          ),
        ),
        Expanded(child: _buildList()),
      ],
    );
  }

  // =========================
  // 🔍 SEARCH
  // =========================
  Widget _buildSearch(bool isDark) {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: "Search hospitals...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: isDark ? Colors.grey[900] : Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // =========================
  // 📂 FILTERS (RESPONSIVE)
  // =========================
  Widget _buildFilters({required bool isHorizontal}) {
    final filters = ["All", "Near Me", "General", "Specialized"];

    if (isHorizontal) {
      return Wrap(
        spacing: 10,
        children: filters.map((f) => _buildFilter(f)).toList(),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: filters.map((f) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _buildFilter(f),
          );
        }).toList(),
      );
    }
  }

  // =========================
  // 🔘 FILTER ITEM
  // =========================
  Widget _buildFilter(String title) {
    final bool isSelected = selectedFilter == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primaryMint : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // =========================
  // 🏥 LIST
  // =========================
  Widget _buildList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: filteredHospitals.map((h) {
        return HospitalCard(
          name: h["name"],
          type: h["type"],
          rating: h["rating"],
          reviews: h["reviews"],
          distance: h["distance"],
          image: h["image"],
        );
      }).toList(),
    );
  }
}

// =========================
// 🏥 CARD
// =========================
class HospitalCard extends StatelessWidget {
  final String name;
  final String type;
  final double rating;
  final int reviews;
  final String distance;
  final String image;

  const HospitalCard({
    super.key,
    required this.name,
    required this.type,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(type, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text("$rating ($reviews)"),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 4),
                      Text("$distance away"),
                      const Spacer(),
                      const Text("Open", style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
