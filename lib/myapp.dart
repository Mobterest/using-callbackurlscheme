import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _callbackData = '';

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      handleLink(
          initialLink!); // Handle the initial link if the app was opened from the callback URL

      // Listen for incoming links while the app is running
      linkStream.listen((link) {
        handleLink(link!);
      });
    } on PlatformException {
      // Handle exception if UniLinks is not supported on the platform
    }
  }

  void handleLink(String link) {
    final uri = Uri.parse(link);
    final callbackData = uri.queryParameters['data'];

    setState(() {
      _callbackData = callbackData!;
    });

    // Perform necessary actions or update the app's state based on the extracted data
    // Example: Trigger a function or update UI elements
    processCallbackData(callbackData!);
  }

  void processCallbackData(String data) {
    // TODO: Implement your logic here based on the callback data
    // Example: Update UI or perform actions based on the received data
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Callback URL Example'),
        ),
        body: Center(
          child: Text('Callback Data: $_callbackData'),
        ),
      ),
    );
  }
}
