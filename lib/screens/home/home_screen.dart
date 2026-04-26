import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_directory/screens/hospitals/hospital_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medical_directory/screens/doctors/doctor_category_screen.dart';
import 'package:medical_directory/main.dart';
import 'package:medical_directory/screens/pharmacy/pharmacy_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // دالة الاتصال بأرقام الطوارئ في ميلة
  Future<void> _makeCall(String number) async {
    final Uri url = Uri.parse('tel:$number');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // ألوان الديزاين الموحدة
    const Color primaryMint = Color(0xFF70FFD8);
    final Color cardBg = isDark ? const Color(0xFF1C2523) : Colors.grey[100]!;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D1412) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Medical Directory Mila",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode,
                color: primaryMint),
            onPressed: () => MyApp.of(context).toggleTheme(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // خانة البحث
            TextField(
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: "Search for Doctor...",
                hintStyle:
                    TextStyle(color: isDark ? Colors.white38 : Colors.black38),
                prefixIcon: const Icon(Icons.search, color: primaryMint),
                filled: true,
                fillColor: isDark ? Colors.grey[900] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 25),

            Text(
              "Category Section",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 15),

            // GridView يستجيب لوضعية الشاشة (2 في الطول، 4 في العرض)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isLandscape ? 4 : 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: isLandscape ? 1.3 : 1.1,
              children: [
                _buildCategoryCard(context, "Doctors",
                    FontAwesomeIcons.userDoctor, cardBg, isDark, onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DoctorCategoryScreen()),
                  );
                }),
                _buildCategoryCard(context, "Hospitals",
                    FontAwesomeIcons.hospital, cardBg, isDark, onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HospitalScreen()),
                  );
                }),
                _buildCategoryCard(
                    context, "Pharmacy", FontAwesomeIcons.pills, cardBg, isDark,
                    onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PharmacyListScreen()),
                  );
                }),
                _buildCategoryCard(context, "Dentistry", FontAwesomeIcons.tooth,
                    cardBg, isDark),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Emergency Hotlines",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent),
            ),
            const SizedBox(height: 10),

            // قائمة الطوارئ تتوزع بشكل أفضل في الـ Landscape
            isLandscape
                ? Row(
                    children: [
                      Expanded(
                          child: _buildEmergencyItem(
                              "Protection Civile", "14", Colors.orange)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _buildEmergencyItem(
                              "Police", "1548", Colors.blue)),
                    ],
                  )
                : Column(
                    children: [
                      _buildEmergencyItem(
                          "Protection Civile", "14", Colors.orange),
                      _buildEmergencyItem("Police", "1548", Colors.blue),
                    ],
                  ),
            _buildEmergencyItem("Gendarmerie Nationale", "1055", Colors.green),
            _buildEmergencyItem("SAMU", "115", Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, IconData icon, Color bg, bool isDark,
      {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, size: 35, color: const Color(0xFF00BFA5)),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyItem(String label, String phone, Color iconColor) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.transparent,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(Icons.phone_forwarded, color: iconColor, size: 20),
        ),
        title: Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        trailing: Text(phone,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue)),
        onTap: () => _makeCall(phone),
      ),
    );
  }
}
