import 'dart:html';

import 'package:flutter/material.dart';

const String flavorDev = "dev-key";
const String flavorProd = "prod-key";

/// To run the app in development:
/// `flutter run -d chrome --dart-define=flavor=dev`
/// To run the app in production:
/// `flutter run -d chrome --dart-define=flavor=prod`

void main() {
  createScriptElement();

  runApp(MyApp());
}

/// Gets the current flavor for the app via the `flavor` environment variable
String currentFlavor() {
  final flavor = const String.fromEnvironment("flavor", defaultValue: "dev");
  if (flavor == "prod") {
    return flavorProd;
  }

  return flavorDev;
}

/// Creates and appends to the `<head>` a new Script element
/// adding the correct `src`
void createScriptElement() {
  /// Create a new JS element
  ScriptElement script = ScriptElement();

  /// On that script element, add the `src` and `id` properties
  script.src = "https://www.some-website-with-api/api=${currentFlavor()}";
  script.id = "super-script";

  document.head.append(script);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic JS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Dynamic JS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'The current key is: ${currentFlavor()}',
            ),
          ],
        ),
      ),
    );
  }
}
