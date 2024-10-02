import 'package:haruviet/database_local/product/cart_database.dart';
import 'package:haruviet/database_local/product/models/cart_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  CartDatabase cartDatabase = CartDatabase.instance;
  int _counter = 0;
  int _quantity = 1;
  int get counter => _counter;
  int get quantity => _quantity;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  List<Products> cart = [];

  Future<List<Products>> getData() async {
    cart = await cartDatabase.readAllItems();
    notifyListeners();
    return cart;
  }

  void _setPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_items', _counter);
    prefs.setInt('item_quantity', _quantity);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void setPrefsItemsLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_items', 0);
    prefs.setInt('item_quantity', 0);
    prefs.setDouble('total_price', 0);
    notifyListeners();
  }

  void _getPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_items') ?? 0;
    _quantity = prefs.getInt('item_quantity') ?? 1;
    _totalPrice = prefs.getDouble('total_price') ?? 0;
  }

  void addCounter() {
    _counter++;
    _setPrefsItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefsItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefsItems();
    return _counter;
  }

  void addQuantity(String idProduct) {
    final index =
        cart.indexWhere((element) => element.idProduct.contains(idProduct));
    cart[index].totalQuantity.value = cart[index].totalQuantity.value + 1;
    _setPrefsItems();
    notifyListeners();
  }

  void deleteQuantity(String idProduct) {
    getData();
    final index =
        cart.indexWhere((element) => element.idProduct.contains(idProduct));
    final currentQuantity = cart[index].totalQuantity.value;
    if (currentQuantity <= 1) {
      currentQuantity == 1;
    } else {
      cart[index].totalQuantity.value = currentQuantity - 1;
    }
    _setPrefsItems();
    notifyListeners();
  }

  Future<void> removeItem(String idProduct) async {
    await getData();
    final index =
        cart.indexWhere((element) => element.idProduct.contains(idProduct));
    cart.removeAt(index);
    _setPrefsItems();
    notifyListeners();
  }

  int getQuantity(int quantity) {
    _getPrefsItems();
    return _quantity;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefsItems();
    return _totalPrice;
  }
}
