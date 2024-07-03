import 'package:eco_app/database_local/product/models/cart_model.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@immutable
class CartDatabase {
  static const String _databaseName = 'cart.db';
  static const int _databaseVersion = 1;

  // Create a singleton
  const CartDatabase._privateConstructor();
  static const CartDatabase instance = CartDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    final String path = join(dbPath, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDB,
    );
  }

  // Create Database method
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'INTEGER NOT NULL';
    const intType =
        'INTEGER NOT NULL'; // Added this line to define int type for totalQuantity

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $productssTable (
        ${CartModel.id} $idType,
        ${CartModel.nameProduct} $textType,
        ${CartModel.description} $textType,
        ${CartModel.totalQuantity} $intType , 
        ${CartModel.isCompleted} $boolType,
        ${CartModel.idProduct} $textType,
        ${CartModel.priceProduct} $textType,
        ${CartModel.brandProduct} $textType,
        ${CartModel.imageProduct} $textType

      )
    ''');
  }

  //! C --> CRUD = Create
  Future<Products> createCart(Products product) async {
    final db = await instance.database;
    final id = await db.insert(
      productssTable,
      product.toMap(),
    );
    // final id = await db.insert(
    //   productssTable,
    //   product.toMap(),
    // );
    return product.copy(id: id);
  }

  //! R -- CURD = Read
  Future<Products> readCart(int id) async {
    final db = await instance.database;

    final productData = await db.query(
      productssTable,
      columns: CartModel.values,
      where: '${CartModel.id} = ?',
      whereArgs: [id],
    );

    if (productData.isNotEmpty) {
      return Products.fromMap(productData.first);
    } else {
      throw Exception('Could not find a product with the given ID');
    }
  }

  // Get All Tasks
  Future<List<Products>> readAllItems() async {
    final db = await instance.database;

    final result = await db.query(
      productssTable,
      //    orderBy: '${CartModel.idProduct} ASC',
    );

    return result.map((productData) => Products.fromMap(productData)).toList();
  }

  //! U --> CRUD = Update
  Future<int> updateCart(Products product) async {
    final db = await instance.database;
    return await db.update(
      productssTable,
      product.toMap(),
      where: '${CartModel.id} = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> markCartAsCompleted({
    required String id,
    required bool isCompleted,
  }) async {
    final db = await instance.database;

    return await db.update(
      productssTable,
      {
        CartModel.isCompleted: isCompleted ? 1 : 0,
      },
      where: '${CartModel.id} = ?',
      whereArgs: [id],
    );
  }

  //! D --> CRUD = Delete
  Future<int> deleteCart(String idProduct) async {
    final db = await instance.database;

    return await db.delete(
      productssTable,
      where: '${CartModel.idProduct} = ?',
      whereArgs: [idProduct],
    );
  }

  //  count total products in database
  Future<int> getCount() async {
    final db = await instance.database;

    var x = await db.rawQuery('SELECT COUNT (*) from $productssTable');
    int? count = Sqflite.firstIntValue(x);
    return count ?? 0;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
