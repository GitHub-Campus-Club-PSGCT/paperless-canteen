import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class PanaromaScreen extends StatelessWidget {
  const PanaromaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text("Find your counter"),
        ),
      ),
      body: Center(
        child: Panorama(
          maxLatitude: 10,
          minLatitude: -10,
          maxLongitude: 140,
          minLongitude: -150,
          sensitivity: 2.5,
          child: Image.asset(
            "assets/images/pano.jpeg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
