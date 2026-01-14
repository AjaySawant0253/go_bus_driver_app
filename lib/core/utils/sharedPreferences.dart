

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late SharedPreferences _prefs;
  
  // Keys for storing data
  static const String _contactKey = 'contact';
  static const String _fcmToken = 'fcmToken';
  static const String _email = 'email';
  static const String _nameKey = 'saved_name';
  static const String _genderKey = 'saved_gender';
  static const String _ageKey = 'saved_age';
  static const String _healthIssueKey = 'saved_health_issue';

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
        _prefs.setString(_contactKey, contact),
        _prefs.setString(_email, email),
        _prefs.setString(_nameKey, name),
        _prefs.setString(_genderKey, gender),
        _prefs.setInt(_ageKey, age),
        if (healthIssue != null) 
          _prefs.setString(_healthIssueKey, healthIssue)
        else 
          Future.value(true),
      ]);
      
      return results.every((result) => result == true);
    } catch (e) {
      print('Error saving contact info: $e');
      return false;
    }
  }

  // Get saved contact
  static String get contact => _prefs.getString(_contactKey) ?? '';

  // Get saved email
  static String get email => _prefs.getString(_email) ?? '';

  // Get saved name
  static String get name => _prefs.getString(_nameKey) ?? '';

  // Get saved gender
  static String get gender => _prefs.getString(_genderKey) ?? 'Male';

  // Get saved age
  static int get age => _prefs.getInt(_ageKey) ?? 0;

  // Get saved health issue
  static String? get healthIssue => _prefs.getString(_healthIssueKey);

  // Check if contact info exists
  static bool get hasContactInfo => 
      _prefs.containsKey(_contactKey) && 
      _prefs.containsKey(_email);

  // Clear all saved contact info
  static Future<void> clearContactInfo() async {
    await Future.wait([
      _prefs.remove(_contactKey),
      _prefs.remove(_email),
      _prefs.remove(_nameKey),
      _prefs.remove(_genderKey),
      _prefs.remove(_ageKey),
      _prefs.remove(_healthIssueKey),
    ]);
  }

  // Save only contact number
  static Future<bool> saveContactNumber(String contact) {
    return _prefs.setString(_contactKey, contact);
  }

  // Save only email
  static Future<bool> saveEmail(String email) {
    return _prefs.setString(_email, email);
  }

  // Get all contact info as a Map
  static Map<String, dynamic> getContactInfo() {
    return {
      'contact': contact,
      'email': email,
      'name': name,
      'gender': gender,
      'age': age,
      'health_issue': healthIssue,
    };
  }
}