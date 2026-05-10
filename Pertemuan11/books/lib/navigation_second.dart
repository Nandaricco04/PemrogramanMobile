import 'package:flutter/material.dart';

class NavigationSecond extends StatefulWidget {
  const NavigationSecond({super.key});

  @override
  State<NavigationSecond> createState() => _NavigationSecondState();
}

class _NavigationSecondState extends State<NavigationSecond> {
  @override
  Widget build(BuildContext context) {
    Color color;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Red'),
              onPressed: () {
                color = const Color.fromARGB(255, 216, 10, 10);
                Navigator.pop(context, color);
              },
            ),
            ElevatedButton(
              child: const Text('B'),
              onPressed: () {
                color = const Color.fromARGB(255, 0, 0, 0);
                Navigator.pop(context, color);
              },
            ),
            ElevatedButton(
              child: const Text('Cyan'),
              onPressed: () {
                color = const Color.fromARGB(255, 25, 210, 195);
                Navigator.pop(context, color);
              },
            ),
          ],
        ),
      ),
    );
  }
}