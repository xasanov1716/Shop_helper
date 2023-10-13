import 'package:flutter/cupertino.dart';
import 'package:last_task/data/models/shop/shop_model_sql.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("shop.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute('''
    CREATE TABLE ${ShopModelFields.tableName} (
    ${ShopModelFields.id} $idType,
    ${ShopModelFields.code} $textType,
    ${ShopModelFields.count} $intType,
    ${ShopModelFields.name} $textType
    )
    ''');

    debugPrint("-------DB----------CREATED---------");
  }


  static Future<List<ShopModel>> getProductByAlphabet(
      String order) async {
    List<ShopModel> allProduct = [];
    final db = await getInstance.database;
    allProduct = (await db.query(ShopModelFields.tableName,
            orderBy: "${ShopModelFields.name} $order"))
        .map((e) => ShopModel.fromJson(e))
        .toList();
    return allProduct;
  }

  static Future<ShopModel> insertProduct(
      ShopModel shopModel) async {
    final db = await getInstance.database;
    final int id = await db.insert(
        ShopModelFields.tableName, shopModel.toJson());
    debugPrint('ID : $id');
    return shopModel.copyWith(id: id);
  }


  static Future<int> deleteProduct(int id) async {
    final db = await getInstance.database;
    int count = await db.delete(
      ShopModelFields.tableName,
      where: "${ShopModelFields.id} = ?",
      whereArgs: [id],
    );
    return count;
  }

  static Future<List<ShopModel>> getAllProduct() async {
    List<ShopModel> allProduct = [];
    final db = await getInstance.database;
    allProduct = (await db.query(ShopModelFields.tableName))
        .map((e) => ShopModel.fromJson(e))
        .toList();
    return allProduct;
  }



  static updateProduct({required ShopModel shopModel}) async {
    final db = await getInstance.database;
    db.update(
      ShopModelFields.tableName,
      shopModel.toJson(),
      where: "${ShopModelFields.id} = ?",
      whereArgs: [shopModel.id],
    );
  }



  static Future<ShopModel?> getSingleProduct(String code) async {
    List<ShopModel> product = [];
    final db = await getInstance.database;
    product = (await db.query(
      ShopModelFields.tableName,
      where: "${ShopModelFields.code} = ?",
      whereArgs: [code],
    ))
        .map((e) => ShopModel.fromJson(e))
        .toList();

    if (product.isNotEmpty) {
      return product.first;
    }
  }


  static Future<void> deleteTable() async {
    Database database = await getInstance.database;
    await database.delete(ShopModelFields.tableName);
  }


}