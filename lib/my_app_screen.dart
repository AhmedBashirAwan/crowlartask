import 'package:flutter/material.dart';
import 'package:movies_app/screens/home.dart';

class MyAppScreen extends StatefulWidget {
  const MyAppScreen({super.key});

  @override
  State<MyAppScreen> createState() => _MyAppScreenState();
}

class _MyAppScreenState extends State<MyAppScreen> {
  // int _selectedTab = 0;

  // final List _pages = const [HomePage()];
  // _changeTab(int index) {
  //   setState(() {
  //     _selectedTab = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomePage(),
      bottomNavigationBar: Theme(
        data: ThemeData(canvasColor: Colors.black),
        child: BottomNavigationBar(
            // currentIndex: _selectedTab,
            // onTap: (index) => _changeTab(index),
            // selectedItemColor: const Color(0xFF75A143),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined), label: "Dashboard"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.play_circle), label: "Watch"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.folder_copy_outlined),
                  label: "Media Library"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.more_horiz_outlined), label: "More"),
            ]),
      ),
    );
  }
}
