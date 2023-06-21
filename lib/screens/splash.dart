import 'package:flutter/material.dart';
import 'package:weather/styles/button.dart';
import 'package:weather/screens/provinces.dart';
//import 'package:weather/services/province_fetch.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 142, 144, 218),
            Color.fromARGB(255, 176, 178, 219)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/1146/1146869.png?w=740&t=st=1686714512~exp=1686715112~hmac=cbfaa89849ad3b6c0aafcfd969702ccf0e48152d3d3188473a9f229342371e1c',
                width: 150,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Weather',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Forecast',
              style: TextStyle(fontSize: 40, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: ElevatedButton(
                style: buttonPrimary,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseProvince()),
                  );
                },
                child: const Text(
                  'Get Start',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
