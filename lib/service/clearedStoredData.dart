import 'package:google_sign_in/google_sign_in.dart';
import 'package:haruviet/data/local/user_preferences.dart';

Future<void> clearSharedPreferencesData() async {
  // Clear all stored data

// Clear all data
  await Preference.clearDataButKeepAppConfig();

  GoogleSignIn().signOut();
}
