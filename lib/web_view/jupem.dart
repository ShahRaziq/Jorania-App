import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class JupemWV extends StatefulWidget {
  @override
  State<JupemWV> createState() => _JupemWVState();
}

class _JupemWVState extends State<JupemWV> {
  late WebViewController controller;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Ramalan pasang surut air 🌊'),
        
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            'https://www.jupem.gov.my/staps/stesen-tanjung-gelang-pahang-1',
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
        onPageStarted: (url) {
          if (url.contains(
              'https://www.jupem.gov.my/staps/stesen-tanjung-gelang-pahang-1')) {
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
      ),
      
    );
  }
}
