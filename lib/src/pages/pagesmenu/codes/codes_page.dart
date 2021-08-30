import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CodesPage extends StatefulWidget {
  const CodesPage({Key? key}) : super(key: key);

  @override
  _CodesPageState createState() => _CodesPageState();
}

class _CodesPageState extends State<CodesPage> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.indigoAccent,
      ),
      body: WebView(
        initialUrl: 'https://sites.google.com/view/gen-promocode/inicio',
      ),
    );
  }
}
