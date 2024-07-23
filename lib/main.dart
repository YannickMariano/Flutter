import 'package:flutter/material.dart';
import 'screens/scan_screen.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScanScreen(),
      routes: {
        '/history': (context) => HistoryScreen(),
      },
    );
  }
}
