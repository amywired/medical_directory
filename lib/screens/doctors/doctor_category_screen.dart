import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'doctors_list_screen.dart';

class DoctorCategoryScreen extends StatelessWidget {
  const DoctorCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // التحقق من المود ومن وضعية الشاشة
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    const Color primaryMint = Color(0xFF70FFD8);
    final Color cardBg = isDark ? const Color(0xFF1C2523) : Colors.grey[100]!;

    // قائمة التخصصات (بدون طبيب الأسنان) بأيقونات باهية
    final List<Map<String, dynamic>> specialties = [
      {'name': 'Generalist', 'icon': FontAwesomeIcons.stethoscope},
      {'name': 'Cardiology', 'icon': FontAwesomeIcons.heartPulse},
      {'name': 'Pediatrics', 'icon': FontAwesomeIcons.baby},
      {'name': 'Neurology', 'icon': FontAwesomeIcons.brain},
      {'name': 'Orthopedics', 'icon': FontAwesomeIcons.bone},
      {'name': 'Radiology', 'icon': FontAwesomeIcons.xRay},
      {'name': 'Ophthalmology', 'icon': FontAwesomeIcons.eye},
      {'name': 'Dermatology', 'icon': FontAwesomeIcons.handDots},
    ];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D1412) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Doctor Specialties",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primaryMint),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Select a specialty for Mila district",
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black54,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // 4 كارد في العرض، 2 في الطول
                crossAxisCount: isLandscape ? 4 : 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                // ضبط الأبعاد حسب الوضعية
                childAspectRatio: isLandscape ? 1.3 : 1.1,
              ),
              itemCount: specialties.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // هنا رح تربطي مع صفحة زميلك (List of doctors)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorsListScreen(
                          specialty: specialties[index]['name'],
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? Colors.white10 : Colors.black12,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                            specialties[index]['icon'],
                            size: 35,
                            color: const Color(0xFF00BFA5)
                        ),
                        const SizedBox(height: 12),
                        Text(
                          specialties[index]['name'],
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
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