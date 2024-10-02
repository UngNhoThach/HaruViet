import 'dart:convert';

import 'package:haruviet/data/reponsitory/product/models/data_product_detail_response/data_product_detail_response.dart';
import 'package:haruviet/data/reponsitory/product/models/price.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/cart_model_v2.dart';

class CartDatabaseV2 {
  static final CartDatabaseV2 _instance = CartDatabaseV2._internal();
  factory CartDatabaseV2() => _instance;
  static const String _databaseName = 'products.db';

  static Database? _database;
  static const int _databaseVersion = 1;
  static const int _maxItems = 20;

  CartDatabaseV2._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<List<CartModelProduct>> readAllItems() async {
    final db = await _instance.database;

    final result = await db.query(
      cartTable,
    );

    return result
        .map((productData) => CartModelProduct.fromMap(productData))
        .toList();
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<List<DataProductDetailResponse>> getAllProducts() async {
    final db = await _instance.database;

    // Lấy tất cả dữ liệu từ bảng products
    final result = await db.query(
      cartTable,
    );

    // Chuyển đổi danh sách CartModelProduct thành DataProductDetailResponse
    return result
        .map((productData) =>
            CartModelProduct.fromMap(productData).toDataProduct())
        .toList();
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $cartTable(
        id TEXT PRIMARY KEY,
        totalQuantity INTEGER,
        options TEXT,
        sku TEXT,
        image TEXT,
        brand TEXT,
        supplier TEXT,
        price TEXT,
        cost TEXT,
        stock INTEGER,
        sold INTEGER,
        minimum INTEGER,
        weightClass TEXT,
        weight TEXT,
        kind INTEGER,
        taxId TEXT,
        approve INTEGER,
        sort INTEGER,
        totalPriceItem DOUBLE,
        view INTEGER,
        dateLastview TEXT,
        dateAvailable TEXT,
        descriptions TEXT,
        categories TEXT,
        images TEXT,
        promotionPrice TEXT
      )
    ''');
  }

  //  not done
  // Phương thức insert mới từ DataProductDetailResponse
  Future<void> insertProductFromDataProduct(
      DataProductDetailResponse product) async {
    // Chuyển đổi từ DataProductDetailResponse sang CartModelProduct
    CartModelProduct cartProduct = CartModelProduct.fromDataProduct(product);
    // Insert vào database như bình thường
    await insertProduct(cartProduct);
  }

  Future<void> insertProduct(
    CartModelProduct product,
  ) async {
    final db = await _instance.database;
    try {
      // Check the current number of items in the database
      final countQuery = await db.rawQuery('SELECT COUNT(*) FROM $cartTable');
      final count = Sqflite.firstIntValue(countQuery);

      // If the count exceeds the limit, delete the oldest item
      if (count != null && count >= _maxItems) {
        await db.rawDelete(
            'DELETE FROM $cartTable WHERE id = (SELECT id FROM $cartTable ORDER BY dateLastview ASC LIMIT 1)');
      }

      // Prepare the product map
      final productMap = product.toMap();

      // Insert the new product with options
      await db.insert(
        cartTable,
        productMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      // print('Product inserted: ${product.id}');
    } catch (e) {
      print('Error inserting product: $e');
    }
  }

  //  update price product
  Future<List<CartModelProduct>> updateProductsDescription({
    required List<Map<String, Price>> product,
  }) async {
    final db = await _instance.database;
    // Danh sách chứa các sản phẩm đã được cập nhật
    List<CartModelProduct> updatedProducts = [];
    // Duyệt qua từng id trong danh sách
    for (var element in product) {
      // Lấy id (từ khóa) và price (giá trị) từ map
      String id = element.keys.first; // lấy key (id) đầu tiên
      Price price = element.values.first; // lấy giá trị (price) đầu tiên
      await db.update(
        cartTable,
        {
          'price': json.encode(price.toJson()),
          'totalPriceItem': price.totalPriceItem,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    }
    updatedProducts = await readAllItems();
    // Trả về danh sách các sản phẩm đã được cập nhật
    return updatedProducts;
  }

  Future<List<CartModelProduct>> products() async {
    final db = await _instance.database;
    final List<Map<String, dynamic>> maps = await db.query(cartTable);
    return List.generate(maps.length, (i) {
      return CartModelProduct.fromMap(maps[i]);
    });
  }

  Future<void> updateProduct(CartModelProduct product) async {
    final db = await _instance.database;
    await db.update(
      cartTable,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> deleteProduct(String id) async {
    final db = await _instance.database;
    await db.delete(
      cartTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
