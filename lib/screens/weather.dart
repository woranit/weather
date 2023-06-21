import 'package:flutter/material.dart';
import 'package:weather/screens/map.dart';
import 'package:weather/styles/button.dart';
import 'package:weather/styles/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key, required this.selectedProvince})
      : super(key: key);

  final String selectedProvince;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic> data = {};
  String error = '';

  bool switchValue = false;
  String celcius = '';

  Future<void> fetchData(String province) async {
    String url =
        'http://api.openweathermap.org/data/2.5/weather?q=$province&appid=54b4eb78009eff9ad25aa26c716f17f8&fbclid=IwAR139JYlHQb2MVBXQh_ihQdrfZ72ICnj31xN92wPo8JxPQj_cbEwREyM1Lc';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);

        setState(() {
          data = json; // Assign the response JSON to 'data'
        });
      } else {
        setState(() {
          error = 'Error: HTTP status code ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.selectedProvince);
  }

  String temp(bool switchValue) {
    if (switchValue == true) {
      double temp = data['main']['temp'] - 273.15;
      return '${temp.toStringAsFixed(2)} °C';
    } else {
      double temp = (data['main']['temp'] - 273.15) * 9 / 5 + 32;
      return '${temp.toStringAsFixed(2)} °F';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF676BD0),
      //   title: const Text('Current Weather'),
      // ),
      body: Center(
        child: error.isNotEmpty // Check if there is an error
            ? Text(error)
            : data.isNotEmpty // Check if data is not empty
                ? Column(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: orange,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 73, 77, 194),
                              const Color.fromARGB(255, 73, 77, 194)
                                  .withOpacity(0.5),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${data['name']}',
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(Icons.location_on),
                                    color:
                                        const Color.fromARGB(255, 48, 56, 128),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Image.network(
                                'http://openweathermap.org/img/w/${data['weather'][0]['icon']}.png',
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: white,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      '${data['weather'][0]['main']}',
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w100,
                                        color: Color.fromARGB(255, 48, 56, 128),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      Text('Temperature',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w100,
                                            color: white,
                                          )),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              switchValue = !switchValue;
                                            });
                                          },
                                          child: Text(
                                            temp(switchValue),
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w100,
                                              color: switchValue == false
                                                  ? Colors.deepOrange[900]
                                                  : Colors.cyan[900],
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text('Wind Speed and Direction',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w100,
                            color: Color(0xff2D3142),
                          )),
                      SizedBox(
                        height: 100,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          //color: const Color(0xFF676BD0),
                          color: const Color(0xffEAE8FF),
                          elevation: 5,
                          margin: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Row(
                              children: [
                                const Icon(Icons.wind_power),
                                const SizedBox(width: 20),
                                Text(
                                  '${data['wind']['speed']}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${data['wind']['deg']}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text('Coordinates',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w100,
                          )),
                      SizedBox(
                        height: 100,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          color: const Color(0xffEAE8FF),
                          elevation: 5,
                          margin: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Row(
                              children: [
                                const Icon(Icons.public),
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${data['coord']['lon']}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                    const Text('Longtitude'),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${data['coord']['lat']}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                    const Text('Latitude'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                      ElevatedButton(
                        onPressed: () {
                          // Perform actions with the selected province
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapProvince(
                                latitude: data['coord']['lat'].toDouble(),
                                longitude: data['coord']['lon'].toDouble(),
                              ),
                            ),
                          );
                        },
                        style: buttonPrimary,
                        child:
                            const Text("Map", style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  )
                : const CircularProgressIndicator(), // Show a progress indicator while loading
      ),
    );
  }
}
