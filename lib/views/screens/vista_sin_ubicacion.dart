import 'package:flutter/material.dart';

class LocationDisabledScreen extends StatelessWidget {
  const LocationDisabledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off, size: 100, color: Colors.black),
            SizedBox(height: 20),
            Text(
              'Los servicios de ubicación están desactivados.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}
