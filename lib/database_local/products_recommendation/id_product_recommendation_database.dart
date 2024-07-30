import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/id_products_recommendation_model.dart';

class IdProductRecommendationDatabase {
  static final IdProductRecommendationDatabase _instance =
      IdProductRecommendationDatabase._internal();
  factory IdProductRecommendationDatabase() => _instance;
  static const String _databaseName = 'productsrecommendation.db';

  static Database? _database;
  static const int _databaseVersion = 1;
  static const int _maxItems = 20;

  IdProductRecommendationDatabase._internal();

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

  Future<List<IdProductRecommendationModel>> getAllProducts() async {
    final db = await _instance.database;

    final result = await db.query(
      idProductsTable,
      // orderBy: '${IdProductRecommendationModel.idProduct} ASC',
    );

    return result
        .map((id) => IdProductRecommendationModel.fromMap(id))
        .toList();
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $idProductsTable(
        id TEXT PRIMARY KEY
      )
    ''');
  }

  Future<void> insertProduct(IdProductRecommendationModel product) async {
    final db = await _instance.database;
    try {
      // Check the current number of items in the database
      final countQuery =
          await db.rawQuery('SELECT COUNT(*) FROM $idProductsTable');
      final count = Sqflite.firstIntValue(countQuery);

      // If the count exceeds the limit, delete the oldest item
      if (count != null && count >= _maxItems) {
        await db.rawDelete(
            'DELETE FROM $idProductsTable WHERE id = (SELECT id FROM $idProductsTable ORDER BY dateLastview ASC LIMIT 1)');
      }
      // Insert the new product
      await db.insert(
        idProductsTable,
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting: $e');
    }
  }

  Future<List<IdProductRecommendationModel>> products() async {
    final db = await _instance.database;
    final List<Map<String, dynamic>> maps = await db.query(idProductsTable);
    return List.generate(maps.length, (i) {
      return IdProductRecommendationModel.fromMap(maps[i]);
    });
  }

  Future<void> updateProduct(IdProductRecommendationModel product) async {
    final db = await _instance.database;
    await db.update(
      idProductsTable,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> deleteProduct(String id) async {
    final db = await _instance.database;
    await db.delete(
      idProductsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
