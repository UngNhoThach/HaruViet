import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearSharedPreferencesData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Clear all stored data
  await prefs.clear();
  await FirebaseAuth.instance.signOut();
  GoogleSignIn().signOut();
}
