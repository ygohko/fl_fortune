import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fl_fortune',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'fl_fourtune'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _fortuneCookieText = 'Press the button to show fortune cookie text.';

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
              _fortuneCookieText,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(
              height: 50.0,
            ),
            SizedBox(
              width: 300.0,
              height: 50.0,
              child: ElevatedButton(
                child: Text('Show'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _updateFortuneCookieText();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateFortuneCookieText() async {
    final response = await http.get(Uri.https('digital-fortune-cookies-api.herokuapp.com', 'fortune'));
    final decoded = json.decode(response.body);
    setState(() {
        _fortuneCookieText = decoded['cookie']['fortune'];
    });
  }
}
