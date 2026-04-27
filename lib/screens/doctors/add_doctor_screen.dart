import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_directory/Database/SqlDb.dart';
import 'package:medical_directory/main.dart';
import 'package:medical_directory/screens/doctors/OptionChoice.dart';
import 'package:medical_directory/screens/doctors/doctors_list_screen.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  Sqldb sqlDb = Sqldb();
  TimeOfDay fromTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay toTime = const TimeOfDay(hour: 17, minute: 0);

  TextEditingController nameController = TextEditingController();
  TextEditingController specialtyController = TextEditingController();
  TextEditingController communeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  TextEditingController workingDaysController = TextEditingController();

  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List<String> selectedDays = [];

  Future<void> selectTime(BuildContext context, bool isFrom) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isFrom ? fromTime : toTime,
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromTime = picked;
        } else {
          toTime = picked;
        }
      });
    }
  }

  bool Phone = false;
  bool inPerson = false;
  String? selectedValue = "Cardiology";
  final List<String> items = [
    "Generalist",
    "Cardiology",
    "Pediatrics",
    "Neurology",
    "Orthopedics",
    "Radiology",
    "Ophthalmology",
    "Dermatology"
  ];

  File? imageFile;
  late var isLandscape =
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color backgroundColor =
        isDark ? const Color(0xFF0D1412) : Colors.white;
    final Color cardColor =
        isDark ? const Color(0xFF1C2523) : Colors.grey[100]!;
    final Color inputFillColor =
        isDark ? const Color(0xFF2C3633) : Colors.grey[200]!;
    const Color accentColor = Color(0xFF86F7E1);
    final Color textColorMain = isDark ? Colors.white : Colors.black;
    final Color textColorDim =
        isDark ? const Color(0xFF9EAAA7) : Colors.grey[600]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: accentColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Doctor',
            style: TextStyle(color: textColorMain, fontSize: 18)),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode,
                color: textColorMain),
            onPressed: () => MyApp.of(context).toggleTheme(),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert, color: textColorMain))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final piker = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (piker != null) {
                        setState(() {
                          imageFile = File(piker.path);
                        });
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF2C3633)
                                  : Colors.grey[200],
                              shape: BoxShape.circle,
                              image: imageFile != null
                                  ? DecorationImage(
                                      image: FileImage(imageFile!),
                                      fit: BoxFit.cover)
                                  : null),
                          child: imageFile == null
                              ? const Icon(Icons.camera_alt_outlined,
                                  color: Colors.grey, size: 30)
                              : null,
                        ),
                        const SizedBox(height: 8),
                        Text("Add Photo",
                            style:
                                TextStyle(color: textColorDim, fontSize: 15)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(9),
              width: 550,
              decoration: BoxDecoration(
                color: const Color.fromARGB(31, 143, 103, 103),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("FULL NAME", textColorDim, 12),
                    _buildTextField("Dr. Julian Sterling", inputFillColor,
                        textColorMain, textColorDim, accentColor,
                        controller: nameController),
                    _buildLabel("Medical Speciality", textColorDim, 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: 310,
                      margin: const EdgeInsets.only(bottom: 5, left: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              value: selectedValue,
                              isExpanded: true,
                              dropdownColor: isDark
                                  ? const Color(0xFF2C3633)
                                  : Colors.white,
                              icon: Icon(Icons.arrow_drop_down,
                                  color: accentColor),
                              style:
                                  TextStyle(color: textColorMain, fontSize: 14),
                              items: items.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue;
                                });
                              })),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(right: 80),
                                child:
                                    _buildLabel("Commune", textColorDim, 15)),
                            _buildTextFieldMin("e.g.. Mila", inputFillColor,
                                textColorMain, textColorDim, accentColor,
                                controller: communeController),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 90),
                              child: _buildLabel("District", textColorDim, 15),
                            ),
                            _buildTextFieldMin(
                              "e.g.. Mila",
                              inputFillColor,
                              textColorMain,
                              textColorDim,
                              accentColor,
                              controller: districtController,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 2),
                    _buildLabel("ADDRESS", textColorDim, 15),
                    _buildTextField(
                      "Address",
                      inputFillColor,
                      textColorMain,
                      textColorDim,
                      accentColor,
                      controller: addressController,
                    ),
                    const SizedBox(height: 7),
                    _buildLabel("PROFESSIONEL EMAIL", textColorDim, 12),
                    _buildTextField(
                      "doctor.email@clinic.com",
                      inputFillColor,
                      textColorMain,
                      textColorDim,
                      accentColor,
                      controller: emailController,
                    ),
                    _buildLabel("PHONE NUMBER", textColorDim, 12),
                    _buildTextField(
                      "+213 050000000000",
                      inputFillColor,
                      textColorMain,
                      textColorDim,
                      accentColor,
                      controller: phoneController,
                    ),
                    const SizedBox(height: 10),
                    _buildLabel("APPOINTMENT METHOD", textColorDim, 12),
                    Row(
                      children: [
                        buildOption(
                            title: "Phone",
                            value: Phone,
                            onChanged: (val) {
                              setState(() {
                                Phone = val ?? false;
                                if (Phone) {
                                  inPerson = false;
                                }
                              });
                            }),
                        buildOption(
                            title: "In Person",
                            value: inPerson,
                            onChanged: (val) {
                              setState(() {
                                inPerson = val ?? false;
                                if (inPerson) {
                                  Phone = false;
                                }
                              });
                            })
                      ],
                    ),
                    _buildLabel("WORKING HOURS", textColorDim, 12),
                    Container(
                      padding: const EdgeInsets.all(7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          builTimebox("From", fromTime, true,
                              controller: fromTimeController),
                          const SizedBox(width: 20),
                          builTimebox("To", toTime, false,
                              controller: toTimeController)
                        ],
                      ),
                    ),
                    _buildLabel("WORKING DAYS", textColorDim, 12),
                    Container(
                      padding: const EdgeInsets.all(9),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: days.length,
                        itemBuilder: (context, index) {
                          String day = days[index];
                          bool isSelected = selectedDays.contains(day);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected
                                    ? selectedDays.remove(day)
                                    : selectedDays.add(day);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? accentColor.withOpacity(0.7)
                                    : Colors.grey[800],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(day,
                                  style: TextStyle(
                                      color: isSelected
                                          ? Colors.black
                                          : textColorDim,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
            ),
            const SizedBox(height: 15),
            Container(
                width: 400,
                height: 150,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 230),
                        child: _buildLabel("SOCILA NETWORK", textColorDim, 12)),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          children: [
                            buildContactfield(
                              "Facebook",
                              inputFillColor,
                              textColorMain,
                              textColorDim,
                              accentColor,
                              icon: Icons.facebook,
                              controller: facebookController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            buildContactfield("Instagram", inputFillColor,
                                textColorMain, textColorDim, accentColor,
                                icon: Icons.social_distance,
                                controller: instagramController),
                          ],
                        )),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  int? response = await sqlDb.insertData('''
                      INSERT INTO Doctor_new (`full_name` , `medical_specialty` , `commune` , `district`, `address`, `phone_number`, `professional_email`, `appointment_phone`, `appointment_in_person`, `working_hours_from`, `working_hours_to`, `working_days`, `facebook`, `instagram`) 
                            
                            VALUES   ("${nameController.text}",
                                       "${selectedValue}",
                                      "${communeController.text}",
                                      "${districtController.text}",
                                      "${addressController.text}",
                                      "${phoneController.text}",
                                      "${emailController.text}",
                                      "${Phone ? 1 : 0}",
                                      "${inPerson ? 1 : 0}",
                                      "${fromTime.format(context)}",
                                      "${toTime.format(context)}",
                                      "${selectedDays.join(', ')}",
                                      "${facebookController.text}",
                                      "${instagramController.text}"
                                    )
                            
                            ''');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DoctorsListScreen(
                            specialty: "${selectedValue}",
                          )));

                  print(response);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E353D),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: const StadiumBorder(),
                  shadowColor: Colors.black45,
                  elevation: 5,
                ),
                label: const Text(
                  "Add Doctor",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFABC4FF)),
                ),
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: Color(0xFFABC4FF),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label, Color color, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 9, left: 13),
      child: Text(label,
          style: TextStyle(
              color: color, fontSize: fontSize, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildTextField(
      String hint, Color fill, Color text, Color hintCol, Color acc,
      {IconData? icon,
      int maxLines = 1,
      required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildTextFieldMin(
    String hint,
    Color fill,
    Color text,
    Color hintCol,
    Color acc, {
    IconData? icon,
    int maxLines = 1,
    required TextEditingController controller,
  }) {
    return SizedBox(
      width: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: controller,
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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget builTimebox(String label, TimeOfDay time, bool isForm,
      {required TextEditingController controller}) {
    return SizedBox(
      width: 145,
      child: GestureDetector(
        onTap: () => selectTime(context, isForm),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 43, 39, 39),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w900)),
              const SizedBox(
                width: 12,
              ),
              Text(time.format(context),
                  style: const TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContactfield(
      String hint, Color fill, Color text, Color hintCol, Color acc,
      {IconData? icon,
      int maxLines = 1,
      required TextEditingController controller}) {
    return SizedBox(
      width: 400,
      height: 37,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: controller,
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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }
}
