import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: WebView(
      initialUrl: "https://www.youtube.com/",
      javascriptMode: JavascriptMode.unrestricted,
    ));
  }
}
