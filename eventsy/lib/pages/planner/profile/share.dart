import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatelessWidget {
  final data;

  const QRCodeGenerator({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        leading: const BackButton(color: Color.fromARGB(255, 18, 140, 126),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
          child: QrImageView(
            data: data,
            version: QrVersions.auto,
            size: 200.0,
            backgroundColor: Colors.white,
          ),
      ),
    );
  }
}
