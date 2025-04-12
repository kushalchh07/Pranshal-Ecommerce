import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationToggle extends StatefulWidget {
  const NotificationToggle({
    Key? key,
  }) : super(key: key);

  @override
  _NotificationToggleState createState() => _NotificationToggleState();
}

class _NotificationToggleState extends State<NotificationToggle> {
  bool isNotificationOn = true;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    _loadNotificationPreference();

    // isNotificationOn = widget.initialValue;
  }

  // Load the user's notification preference from SharedPreferences
  Future<void> _loadNotificationPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Load the saved preference or fallback to the widget's initialValue
      isNotificationOn = prefs.getBool('isNotificationOn') ?? true;
    });
  }

  // Save the user's notification preference to SharedPreferences
  Future<void> _saveNotificationPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isNotificationOn', value);
  }

// Enable push notifications
  Future<void> _enablePushNotifications() async {
    // Request permission for notifications (for iOS)
    // NotificationSettings settings = await _firebaseMessaging.requestPermission(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );

    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   // Subscribe to a topic or get a device token
    //   String? token = await _firebaseMessaging.getToken();
    //   print('FCM Token: $token');
    //   // You can subscribe to a topic here
    //   // await _firebaseMessaging.subscribeToTopic('your_topic');
    // }
    // await _firebaseMessaging.subscribeToTopic('all');
  }

  Future<void> _disablePushNotifications() async {
    // Unsubscribe from notifications or a specific topic
    // await _firebaseMessaging.unsubscribeFromTopic('your_topic');
    // await _firebaseMessaging.deleteToken();
    // await _firebaseMessaging.unsubscribeFromTopic('all');
    print('Notifications disabled');
  }

  void _toggleNotification() async {
    setState(() {
      isNotificationOn = !isNotificationOn;
    });

    if (isNotificationOn) {
      // Enable notifications
      await _enablePushNotifications(); // Or _enableLocalNotifications();
    } else {
      // Disable notifications
      await _disablePushNotifications(); // Or _disableLocalNotifications();
    }
// Save the toggle state in SharedPreferences
// Save the toggle state in SharedPreferences
    await _saveNotificationPreference(isNotificationOn);
    log("isNotificationOn $isNotificationOn");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleNotification,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 45, // Adjusted width
        height: 25, // Adjusted height
        padding: EdgeInsets.all(4), // Adjusted padding
        decoration: BoxDecoration(
          color: isNotificationOn ? Colors.green : Colors.grey[800],
          borderRadius: BorderRadius.circular(
              15), // Adjusted border radius for smaller size
        ),
        child: AnimatedAlign(
          duration: Duration(milliseconds: 300),
          alignment:
              isNotificationOn ? Alignment.centerRight : Alignment.centerLeft,
          curve: Curves.easeInOut,
          child: Container(
            width: 22, // Adjusted circle width
            height: 22, // Adjusted circle height
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
