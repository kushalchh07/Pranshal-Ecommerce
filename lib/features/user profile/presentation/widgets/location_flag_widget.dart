import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationFlagWidget extends StatefulWidget {
  @override
  _LocationFlagWidgetState createState() => _LocationFlagWidgetState();
}

class _LocationFlagWidgetState extends State<LocationFlagWidget> {
  String? countryFlag;
  String? countryName;

  @override
  void initState() {
    super.initState();
    _getCurrentLocationAndFlag();
  }

  Future<void> _getCurrentLocationAndFlag() async {
    try {
      // Request location permissions
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          countryFlag = "❌"; // No permission
          countryName = "Permission Denied";
        });
        return;
      }

      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Reverse geocode to get the country
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        String countryCode = placemarks[0].isoCountryCode ?? "";
        String name = placemarks[0].country ?? "";

        setState(() {
          countryFlag = _getFlagEmoji(countryCode);
          countryName = name;
        });
      }
    } catch (e) {
      setState(() {
        countryFlag = "❌";
        countryName = "Error: ${e.toString()}";
      });
    }
  }

  // Function to convert country code to flag emoji
  String _getFlagEmoji(String countryCode) {
    return countryCode.toUpperCase().runes.map((code) {
      return String.fromCharCode(0x1F1E6 + code - 0x41);
    }).join();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            countryFlag ?? "🌍",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            countryName ?? "Fetching location...",
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
