import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TideForcastWV extends StatefulWidget {
  @override
  State<TideForcastWV> createState() => _TideForcastWVState();
}

class _TideForcastWVState extends State<TideForcastWV> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Ramalan terperinci ⛵'),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                controller.goBack();
              },
            )
          ],
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              'https://www.tide-forecast.com/locations/Kuantan-Malaysia/tides/latest',
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          onPageStarted: (url) {
            if (url.contains(
                'https://www.tide-forecast.com/locations/Kuantan-Malaysia/tides/latest')) {
              Future.delayed(Duration(milliseconds: 200), () {
                //remove header
                controller.runJavascript(
                    "document.getElementsByTagName('header')[0].style.display='none'");
                //remove footer
                controller.runJavascript(
                    "document.getElementsByTagName('footer')[0].style.display='none'");
              });
            }
          },
        ));
  }
}
