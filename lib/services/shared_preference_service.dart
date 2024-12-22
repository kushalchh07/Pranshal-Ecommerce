import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String keyEmail = 'contact';
  static const String keyPassword = 'password';
  static const String keyIsRememberMe = 'isRememberMe';
  // Add other keys you're using
  static const String keyUnreadCount = 'unreadCount';
  static const String keyUserToken = 'userToken';
  static const String keyUserId = 'userId';
  // Add all other keys you're using in SharedPreferences

  static Future<void> clearOnLogout() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // First check if remember me is true
      bool isRememberMe = prefs.getBool(keyIsRememberMe) ?? false;

      if (isRememberMe) {
        // If remember me is true, save the values we want to keep
        String? savedEmail = prefs.getString(keyEmail);
        String? savedPassword = prefs.getString(keyPassword);

        // Clear all preferences
        await prefs.clear();

        // Restore the values we want to keep
        await prefs.setString(keyEmail, savedEmail ?? '');
        await prefs.setString(keyPassword, savedPassword ?? '');
        await prefs.setBool(keyIsRememberMe, true);
      } else {
        // If remember me is false, clear everything
        await prefs.clear();
      }

      print('SharedPreferences cleared successfully');
    } catch (e) {
      print('Error clearing SharedPreferences: $e');
    }
  }

  // Helper method to clear specific keys
  static Future<void> clearSpecificKeys(List<String> keysToRemove) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      for (String key in keysToRemove) {
        await prefs.remove(key);
      }
    } catch (e) {
      print('Error clearing specific keys: $e');
    }
  }

  // Helper method to save remember me status
  static Future<void> saveRememberMe({
    required String email,
    required String password,
    required bool isRememberMe,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(keyIsRememberMe, isRememberMe);
      if (isRememberMe) {
        await prefs.setString(keyEmail, email);
        await prefs.setString(keyPassword, password);
      }
    } catch (e) {
      print('Error saving remember me status: $e');
    }
  }

  // Helper method to get saved credentials
  static Future<Map<String, dynamic>> getSavedCredentials() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      return {
        'contact': prefs.getString(keyEmail) ?? '',
        'password': prefs.getString(keyPassword) ?? '',
        'isRememberMe': prefs.getBool(keyIsRememberMe) ?? false,
      };
    } catch (e) {
      print('Error getting saved credentials: $e');
      return {
        'contact': '',
        'password': '',
        'isRememberMe': false,
      };
    }
  }

  // Method to check if user is remembered
  static Future<bool> isUserRemembered() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(keyIsRememberMe) ?? false;
    } catch (e) {
      print('Error checking if user is remembered: $e');
      return false;
    }
  }
}
