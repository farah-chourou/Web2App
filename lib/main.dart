import 'package:convertisseur_web_app/AboutUs.dart';
import 'package:convertisseur_web_app/Home.dart';
import 'package:convertisseur_web_app/Settings.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
    return MaterialApp(debugShowCheckedModeBanner: false, home: BottomNav());
  }
}

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _page = 1;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> screens = [Home(), AboutUs()];
  List listState = [];
  String? hexString = dotenv.env['THEME_COLOR'];
  final appName = dotenv.env['NAME_APP'].toString();

  String urlLogo = dotenv.env['URL_ICON'].toString();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      extendBody: true,
      body: getBody(),
      drawer: Settings(),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 1,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.contact_page, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.settings, size: 30),
          ],
          color: Color(int.parse("0xff$hexString")),
          buttonBackgroundColor: Color(int.parse("0xff$hexString")),
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            if (_page == index) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            } else {
              setState(() {
                _page = index;
              });
            }
          },
        ),
      ),
    );
  }

  Widget getBody() {
    if (_page == 1) {
      return Home();
    } else if (_page == 0) {
      return AboutUs();
    } else {
      return const Settings();
    }
  }
}
