import 'package:path/path.dart';
import 'package:product_receipt/model/item.dart';
import 'package:sqflite/sqflite.dart';


class ItemsDatabase {
  ItemsDatabase._init();
  static final ItemsDatabase instance = ItemsDatabase._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('item.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableItems (
    ${ItemsFields.id} $idType,
    ${ItemsFields.name} $textType,
    ${ItemsFields.code} $textType,
    ${ItemsFields.rate} $textType
    )
    ''');
  }

  Future<Item> create(Item item) async {
    final db = await instance.database;


    final id = await db.insert(tableItems, item.toJson());
    return item.copy(id: id);
  }

  Future<Item> readItem(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableItems,
      columns: ItemsFields.values,
      where: '${ItemsFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return Item.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id not found');
    }

  }


  Future<List<Item>> readAllItem() async{
    final db = await instance.database;

    final result = await db.query(tableItems);
    return result.map((json) => Item.fromJson(json)).toList();
  }
  Future<int> update(Item item) async {
    final db = await instance.database;

    return db.update(
      tableItems,
      item.toJson(),
      where: '${ItemsFields.id} = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableItems,
      where: '${ItemsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}






