import 'package:convertisseur_web_app/AboutUs.dart';
import 'package:convertisseur_web_app/Home.dart';
import 'package:convertisseur_web_app/Settings.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner:
            false, // bich yna7ili kilmiit debuug 3ala jnab
        home: BottomNav());
  }
}

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> screens = [AboutUs(), Home(), Settings()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[_page],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.pink)),
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.settings, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.orange,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
