// lib/screens/history_screen.dart
import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/scanned_code.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final DatabaseService _databaseService = DatabaseService();
  late Future<List<ScannedCode>> _scannedCodes;

  @override
  void initState() {
    super.initState();
    _scannedCodes = _databaseService.getScannedCodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scanned Codes History')),
      body: FutureBuilder<List<ScannedCode>>(
        future: _scannedCodes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No scanned codes found.'));
          } else {
            final codes = snapshot.data!;
            return ListView.builder(
              itemCount: codes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(codes[index].code),
                );
              },
            );
          }
        },
      ),
    );
  }
}
