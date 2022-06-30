import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: WebView(
      initialUrl: "https://www.youtube.com/",
      javascriptMode: JavascriptMode.unrestricted,
    ));
  }
}
