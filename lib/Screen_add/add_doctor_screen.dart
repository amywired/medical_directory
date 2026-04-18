import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: AddDoctorScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class AddDoctorScreen extends StatelessWidget {
  const AddDoctorScreen({super.key});
  
  final Color backgroundColor = const Color(0xFF0D1412);
  final Color cardColor = const Color(0xFF1C2523);
  final Color inputFillColor = const Color(0xFF2C3633);
  final Color accentColor = const Color(0xFF86F7E1);
  final Color textColorMain = Colors.white;
  final Color textColorDim = const Color(0xFF9EAAA7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: accentColor),
        title: Text('Add Doctor', style: TextStyle(color: textColorMain, fontSize: 18)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.white))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text('NEW PRACTITIONER', style: TextStyle(color: textColorDim, fontSize: 11, letterSpacing: 1)),
            const SizedBox(height: 5),
            Text('Clinical Onboarding', style: TextStyle(color: textColorMain, fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(width: 40, height: 3, color: accentColor),
            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.black26,
                    child: Icon(Icons.add_a_photo_outlined, color: textColorDim, size: 30),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Doctor's Photo", style: TextStyle(color: textColorMain, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("Upload a professional headshot.", style: TextStyle(color: textColorDim, fontSize: 12)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),

            _buildLabel("FULL NAME"),
            _buildTextField("Dr. Julian Sterling"),
            
            _buildLabel("MEDICAL SPECIALTY"),
            _buildTextField("e.g. Cardiology"),

            _buildLabel("CLINIC LOCATION"),
            _buildTextField("St. Mary's Medical Center", icon: Icons.location_on_outlined),

            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: Divider(color: Colors.white10)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("CONTACT", style: TextStyle(color: textColorDim, fontSize: 10)),
                ),
                Expanded(child: Divider(color: Colors.white10)),
              ],
            ),
            const SizedBox(height: 15),

            _buildTextField("+1 (555) 000-0000", icon: Icons.phone_outlined),
            const SizedBox(height: 12),
            _buildTextField("doctor.name@clinic.com", icon: Icons.email_outlined),

            _buildLabel("PRACTITIONER BIO"),
            _buildTextField("Brief description of experience...", maxLines: 4),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0F221F),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: accentColor, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "This profile will be visible to registered patients after verification.",
                      style: TextStyle(color: accentColor, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {},
                icon: const Icon(Icons.save_outlined, color: Color(0xFF0D1412)),
                label: const Text("Add", style: TextStyle(color: Color(0xFF0D1412), fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(label, style: TextStyle(color: textColorDim, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildTextField(String hint, {IconData? icon, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: TextStyle(color: textColorMain),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: textColorDim, fontSize: 14),
        prefixIcon: icon != null ? Icon(icon, color: accentColor, size: 20) : null,
        filled: true,
        fillColor: inputFillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}