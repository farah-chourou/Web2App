import 'package:convertisseur_web_app/AboutUs.dart';
import 'package:convertisseur_web_app/Home.dart';
import 'package:convertisseur_web_app/Settings.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> screens = [AboutUs(), Home()];
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
      /*   appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.replay_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),*/
      body: getBody(),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Color(int.parse("0xff$hexString")),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(
                          top: 30,
                          bottom: 15,
                        ),
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(urlLogo)),
                    Text(
                      appName,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
                leading: Icon(Icons.home),
                title: const Text(
                  'About us',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContextncontext) => AboutUs()));
                }),
            const ListTile(
              leading: Icon(Icons.share),
              title: Text(
                'Share',
                style: TextStyle(fontSize: 18),
              ),
              onTap: null,
            ),
            const ListTile(
              leading: Icon(Icons.close),
              title: Text(
                'Close',
                style: TextStyle(fontSize: 18),
              ),
              onTap: null,
            )
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.settings, size: 30),
          ],
          color: Color(int.parse("0xff$hexString")),
          buttonBackgroundColor: Color(int.parse("0xff$hexString")),
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
      ),
    );
  }

  getScreen() {
    if (_page == 1) {
      Home();

      _key.currentState?.openDrawer();
    } else if (_page == 0) {
      return AboutUs();
    } else {
      return Settings();
    }
  }

  Widget getBody() {
    if (_page == 1) {
      return Home();
    } else if (_page == 0) {
      return AboutUs();
    } else {
      return getScreen();
    }
  }
}
