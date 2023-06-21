import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:weather/styles/button.dart';
import 'package:weather/screens/weather.dart';
import 'package:weather/screens/splash.dart';
//import 'package:weather/styles/color.dart';

class ChooseProvince extends StatefulWidget {
  const ChooseProvince({Key? key}) : super(key: key);

  @override
  State<ChooseProvince> createState() => _ChooseProvinceState();
}

class _ChooseProvinceState extends State<ChooseProvince> {
  List<dynamic> provinceList = [];
  final jobRoleCtrl = TextEditingController();
  bool isButtonActive = false;

  Future getProvince() async {
    try {
      String url =
          'https://raw.githubusercontent.com/kongvut/thai-province-data/master/api_province.json?fbclid=IwAR1tB4aClgU7FdIAoohgvLXtu0sAI5vQNuZIck9LQqoBqRVO_H_fo0ESxrE';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonString = response.body;
        var jsonData = jsonDecode(jsonString);
        setState(() {
          provinceList = jsonData;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getProvince();
    jobRoleCtrl.addListener(isPick);
  }

  isPick() {
    if (jobRoleCtrl.text.isNotEmpty) {
      setState(() {
        isButtonActive = true;
      });
    } else {
      setState(() {
        isButtonActive = false;
      });
    }
  }

  @override
  void dispose() {
    jobRoleCtrl.removeListener(isPick);
    jobRoleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents overflow error
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SplashScreen(),
              ),
            );
          },
        ),
        backgroundColor: const Color(0xFF676BD0),
        title: const Text(
          "Location",
        ),
      ),
      body: provinceList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const Text(
                        "Where are you?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: CustomDropdown.search(
                        hintText: 'Select Province',
                        items: provinceList
                            .map((item) => item['name_en'].toString())
                            .toList(),
                        controller: jobRoleCtrl,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Image.asset(
                      'images/young_door.png',
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: isButtonActive
                          ? () {
                              // Perform actions with the selected province
                              print(jobRoleCtrl.text);
                              String selectedProvince = jobRoleCtrl.text;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WeatherScreen(
                                      selectedProvince: selectedProvince),
                                ),
                              );
                            }
                          : null,
                      style: buttonPrimary,
                      child: const Text("Next", style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
