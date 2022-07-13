import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
                    initialUrl: dotenv.env['URL_ABOUT_US'],
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      setState(() {
                        _controller = webViewController;
                      });
                    },
                    onPageStarted: (url) {},
                    onPageFinished: (url) {
                      if (mounted)
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
