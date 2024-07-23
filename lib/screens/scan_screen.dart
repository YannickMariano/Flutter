// lib/screens/scan_screen.dart
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../services/database_service.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan QR Code')),
      body: QRView(
        key: qrKey,
        onQRViewCreated: (QRViewController controller) {
          setState(() {
            _controller = controller;
          });
          _controller?.scannedDataStream.listen((scanData) async {
            final String? code = scanData.code;
            if (code != null && code.isNotEmpty) { // vérifiez null et non vide
              await _databaseService.insertScannedCode(code);
              Navigator.pushNamed(context, '/history');
            }
          });
        },
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/history');
        },
        child: Icon(Icons.history),
        tooltip: 'Go to History',
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
