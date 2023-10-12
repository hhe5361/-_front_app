import 'package:flutter/material.dart';
import 'package:trackproject/src/View/AIPage/AiMainPage.dart';
import 'package:trackproject/src/View/CameraPage/MainCameraPage.dart';
import 'package:trackproject/src/View/MyPage/MainUserPage.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
//import 'package:trackproject/src/widgets/AnimatedIndexdPage.dart';
//앱의 navigation과 appbar 부분

class AppThema extends StatefulWidget {
  const AppThema({super.key});

  @override
  State<AppThema> createState() => _AppThemaState();
}

class _AppThemaState extends State<AppThema> {
  int _currentpage = 1;
  final List<Widget> _pages = <Widget>[
    const MainAiPage(),
    const MainCameraPage(),
    const MainUserPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: myappbar,
          body: _pages.elementAt(_currentpage),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.auto_fix_high_outlined),
                  activeIcon: Icon(Icons.auto_fix_high),
                  label: "Ai"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.camera_alt_outlined),
                  activeIcon: Icon(Icons.camera_alt_rounded),
                  label: "camera"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "user"),
            ],
            currentIndex: _currentpage,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed, //(2)
            selectedItemColor: Colors.black,
            onTap: _onItemTapped,
          )),
    );
  }
}

//button 구조
