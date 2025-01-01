import 'package:haruviet/data/reponsitory/product/models/data_list_product/data_product_list.dart';
import 'package:haruviet/database_local/product/models/cart_model_v2.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductRecommendationDatabase {
  static final ProductRecommendationDatabase _instance =
      ProductRecommendationDatabase._internal();

  factory ProductRecommendationDatabase() => _instance;
  static const String _databaseName = 'productsrecommen.db';
  String productsTable = 'productsrecommen';
  static Database? _database;
  static const int _databaseVersion = 1;
  static const int _maxItems = 12;

  ProductRecommendationDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<List<DataProduct>> getAllProducts({int? limit}) async {
    final db = await _instance.database;

    final result = await db.query(
      productsTable,
      limit: limit,
    );
    return result
        .map((productData) =>
            CartModelProduct.fromMap(productData).toDataProduct())
        .toList();
    // return result.map((json) => DataProduct.fromJson(json)).toList();
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $productsTable(
        id TEXT PRIMARY KEY,
        totalQuantity INTEGER,
        options TEXT,
        discount TEXT,
        promotiondetails TEXT,
        reviews TEXT,
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

  // Future<void> insertProduct(ProductRecommendationModel product) async {
  //   final db = await _instance.database;
  //   try {
  //     await db.insert(
  //       productsTable,
  //       product.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //     print('Product inserted: ${product.id}');
  //   } catch (e) {
  //     print('Error inserting product: $e');
  //   }
  // }

  // Phương thức insert mới từ DataProduct
  Future<void> insertProductFromDataProductRecommen(
      {required DataProduct product}) async {
    // Chuyển đổi từ DataProduct sang CartModelProduct
    CartModelProduct cartProduct = CartModelProduct.fromDataProduct(product);
    // Insert vào database như bình thường
    await insertProductRecommen(cartProduct);
  }

  Future<void> insertProductRecommen(CartModelProduct product) async {
    final db = await _instance.database;
    try {
      // Check the current number of items in the database
      final countQuery =
          await db.rawQuery('SELECT COUNT(*) FROM $productsTable');
      final count = Sqflite.firstIntValue(countQuery);

      // If the count exceeds the limit, delete the oldest item
      if (count != null && count >= _maxItems) {
        await db.rawDelete(
            'DELETE FROM $productsTable WHERE id = (SELECT id FROM $productsTable ORDER BY dateLastview ASC LIMIT 1)');
      }
      // Insert the new product
      await db.insert(
        productsTable,
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      //  print('Product inserted: ${product.id}');
    } catch (e) {
      print('Error inserting product: $e');
    }
  }

  Future<List<CartModelProduct>> products() async {
    final db = await _instance.database;
    final List<Map<String, dynamic>> maps = await db.query(productsTable);
    return List.generate(maps.length, (i) {
      return CartModelProduct.fromMap(maps[i]);
    });
  }

  Future<void> updateProduct(CartModelProduct product) async {
    final db = await _instance.database;
    await db.update(
      productsTable,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> deleteProduct(String id) async {
    final db = await _instance.database;
    await db.delete(
      productsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
