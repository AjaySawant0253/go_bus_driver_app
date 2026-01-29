

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late SharedPreferences _prefs;
  
  // Keys for storing data
  static const String name = 'name';
  static const String email = 'email';
  static const String contact = 'contact';
  static const String gender = 'gender';
  static const String empImg = 'empImg';
  static const String _ageKey = 'age';

  // Initialize SharedPreferences
  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save contact information
  static Future<bool> saveContactInfo({
    required String contact,
    required String email,
    required String name,
    required String gender,
    required int age,
    String? healthIssue,
  }) async {
    try {
      final results = await Future.wait([
        _prefs.setString(name, contact),
        _prefs.setString(email, email),
        _prefs.setString(name, name),
        _prefs.setString(gender, gender),
        _prefs.setInt(_ageKey, age),
        if (empImg.isNotEmpty) 
          _prefs.setString(empImg, empImg)
        else 
          Future.value(true),
      ]);
      
      return results.every((result) => result == true);
    } catch (e) {
      print('Error saving contact info: $e');
      return false;
    }
  }


  // Clear all saved contact info
  static Future<void> clearContactInfo() async {
    await Future.wait([
      _prefs.remove(contact),
      _prefs.remove(email),
      _prefs.remove(name),
      _prefs.remove(gender),
      _prefs.remove(empImg),
    ]);
  }

  }