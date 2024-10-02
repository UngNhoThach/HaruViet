import 'package:haruviet/database_local/products_recommendation/models/products_recommendation_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductRecommendationDatabase {
  static final ProductRecommendationDatabase _instance =
      ProductRecommendationDatabase._internal();

  factory ProductRecommendationDatabase() => _instance;
  static const String _databaseName = 'products.db';

  static Database? _database;
  static const int _databaseVersion = 1;
  static const int _maxItems = 20;

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

  Future<List<ProductRecommendationModel>> getAllProducts() async {
    final db = await _instance.database;

    final result = await db.query(
      productsTable,
      //    orderBy: '${CartModel.idProduct} ASC',
    );

    return result
        .map((productData) => ProductRecommendationModel.fromMap(productData))
        .toList();
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $productsTable(
        id TEXT PRIMARY KEY,
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

  Future<void> insertProduct(ProductRecommendationModel product) async {
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

  Future<List<ProductRecommendationModel>> products() async {
    final db = await _instance.database;
    final List<Map<String, dynamic>> maps = await db.query(productsTable);
    return List.generate(maps.length, (i) {
      return ProductRecommendationModel.fromMap(maps[i]);
    });
  }

  Future<void> updateProduct(ProductRecommendationModel product) async {
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
