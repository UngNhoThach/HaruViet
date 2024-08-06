import 'package:haruviet/database_local/suggestion_data_search/models/suggestion_data_search_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SuggestionDataSearchDatabase {
  static final SuggestionDataSearchDatabase _instance =
      SuggestionDataSearchDatabase._internal();
  factory SuggestionDataSearchDatabase() => _instance;
  static const String _databaseName = 'datasearchsuggestion.db';

  static Database? _database;
  static const int _databaseVersion = 1;
  static const int _maxItems = 12;

  SuggestionDataSearchDatabase._internal();

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

  Future<List<SuggestionDataSearchModel>> getAllDataSearch() async {
    final db = await _instance.database;

    final result = await db.query(
      dataSearchSuggestion,
      // orderBy: '${SuggestionDataSearchModel.idProduct} ASC',
    );

    return result
        .map((value) => SuggestionDataSearchModel.fromMap(value))
        .toList();
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $dataSearchSuggestion(
        value TEXT PRIMARY KEY,
        dateLastview INTEGER
      )
    ''');
  }

  Future<void> insertDataSearch(SuggestionDataSearchModel product) async {
    final db = await _instance.database;
    try {
      // Check if the product already exists
      await db.delete(
        dataSearchSuggestion,
        where: 'value = ?',
        whereArgs: [product.value],
      );

      // Check the current number of items in the database
      final countQuery =
          await db.rawQuery('SELECT COUNT(*) FROM $dataSearchSuggestion');
      final count = Sqflite.firstIntValue(countQuery);

      // If the count exceeds the limit, delete the oldest item
      if (count != null && count >= _maxItems) {
        await db.rawDelete(
            'DELETE FROM $dataSearchSuggestion WHERE value = (SELECT value FROM $dataSearchSuggestion ORDER BY dateLastview ASC LIMIT 1)');
      }

      // Insert the new product
      await db.insert(
        dataSearchSuggestion,
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting: $e');
    }
  }

  Future<List<SuggestionDataSearchModel>> dataSearch() async {
    final db = await _instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(dataSearchSuggestion);
    return List.generate(maps.length, (i) {
      return SuggestionDataSearchModel.fromMap(maps[i]);
    });
  }

  Future<void> updateDataSearch(SuggestionDataSearchModel product) async {
    final db = await _instance.database;
    await db.update(
      dataSearchSuggestion,
      product.toMap(),
      where: 'value = ?',
      whereArgs: [product.value],
    );
  }

  Future<void> deleteDataSearch(String value) async {
    final db = await _instance.database;
    await db.delete(
      dataSearchSuggestion,
      where: 'value = ?',
      whereArgs: [value],
    );
  }
}
