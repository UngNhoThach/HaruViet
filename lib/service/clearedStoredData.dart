import 'package:google_sign_in/google_sign_in.dart';
import 'package:haruviet/database_local/product/cart_database.dart';
import 'package:haruviet/database_local/product/cart_database_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearSharedPreferencesData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Clear all stored data

  await prefs.clear();
  // await FirebaseAuth.instance.signOut();
  // await CartDatabaseV2().deleteProduct(id);
  GoogleSignIn().signOut();
}
