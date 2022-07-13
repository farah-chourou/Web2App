import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late WebViewController _controller;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => Future.delayed(const Duration(seconds: 0), () {
            _controller.reload();
            setState(() {});
          }),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  WebView(
                    initialUrl: dotenv.env['URL_HOME_PAGE'],
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      setState(() {
                        _controller = webViewController;
                      });
                    },
                    onPageStarted: (url) {},
                    onPageFinished: (url) {
                      setState(
                        () {
                          isLoading = false;
                        },
                      );
                    },
                  ),
                  if (isLoading)
                    const Center(
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
