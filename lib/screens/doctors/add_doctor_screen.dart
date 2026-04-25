import 'package:flutter/material.dart';
import '../../main.dart';

class AddDoctorScreen extends StatelessWidget {
  const AddDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color backgroundColor = isDark ? const Color(0xFF0D1412) : Colors.white;
    final Color cardColor = isDark ? const Color(0xFF1C2523) : Colors.grey[100]!;
    final Color inputFillColor = isDark ? const Color(0xFF2C3633) : Colors.grey[200]!;
    const Color accentColor = Color(0xFF86F7E1);
    final Color textColorMain = isDark ? Colors.white : Colors.black;
    final Color textColorDim = isDark ? const Color(0xFF9EAAA7) : Colors.grey[600]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: accentColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Doctor', style: TextStyle(color: textColorMain, fontSize: 18)),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: textColorMain),
            onPressed: () => MyApp.of(context).toggleTheme(),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert, color: textColorMain))
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
                    backgroundColor: isDark ? Colors.black26 : Colors.black12,
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

            _buildLabel("FULL NAME", textColorDim),
            _buildTextField("Dr. Julian Sterling", inputFillColor, textColorMain, textColorDim, accentColor),

            _buildLabel("MEDICAL SPECIALTY", textColorDim),
            _buildTextField("e.g. Cardiology", inputFillColor, textColorMain, textColorDim, accentColor),

            _buildLabel("CLINIC LOCATION", textColorDim),
            _buildTextField("St. Mary's Medical Center", inputFillColor, textColorMain, textColorDim, accentColor, icon: Icons.location_on_outlined),

            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: Divider(color: isDark ? Colors.white10 : Colors.black12)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("CONTACT", style: TextStyle(color: textColorDim, fontSize: 10)),
                ),
                Expanded(child: Divider(color: isDark ? Colors.white10 : Colors.black12)),
              ],
            ),
            const SizedBox(height: 15),

            _buildTextField("+1 (555) 000-0000", inputFillColor, textColorMain, textColorDim, accentColor, icon: Icons.phone_outlined),
            const SizedBox(height: 12),
            _buildTextField("doctor.name@clinic.com", inputFillColor, textColorMain, textColorDim, accentColor, icon: Icons.email_outlined),

            _buildLabel("PRACTITIONER BIO", textColorDim),
            _buildTextField("Brief description of experience...", inputFillColor, textColorMain, textColorDim, accentColor, maxLines: 4),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0F221F) : const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: accentColor, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "This profile will be visible to registered patients after verification.",
                      style: TextStyle(color: isDark ? accentColor : Colors.teal, fontSize: 12),
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

  Widget _buildLabel(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildTextField(String hint, Color fill, Color text, Color hintCol, Color acc, {IconData? icon, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: TextStyle(color: text),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: hintCol, fontSize: 14),
        prefixIcon: icon != null ? Icon(icon, color: acc, size: 20) : null,
        filled: true,
        fillColor: fill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}