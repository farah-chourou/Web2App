import 'package:convertisseur_web_app/AboutUs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final appName = dotenv.env['NAME_APP'].toString();

  String urlLogo = dotenv.env['URL_ICON'].toString();
  String? hexString = dotenv.env['THEME_COLOR'];

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
