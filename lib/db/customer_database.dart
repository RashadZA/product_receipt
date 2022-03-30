import 'package:path/path.dart';
import 'package:product_receipt/model/customer.dart';
import 'package:sqflite/sqflite.dart';


class CustomersDatabase {
  CustomersDatabase._init();
  static final CustomersDatabase instance = CustomersDatabase._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('customer.db');

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
    CREATE TABLE $tableCustomers (
    ${CustomerFields.id} $idType,
    ${CustomerFields.name} $textType,
    ${CustomerFields.number} $textType,
    ${CustomerFields.email} $textType
    )
    ''');
  }

  Future<Customer> create(Customer customer) async {
    final db = await instance.database;


    final id = await db.insert(tableCustomers, customer.toJson());
    return customer.copy(id: id);
  }

  Future<Customer> readCustomer(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCustomers,
      columns: CustomerFields.values,
      where: '${CustomerFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return Customer.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id not found');
    }

  }


  Future<List<Customer>> readAllCustomer() async{
    final db = await instance.database;

    // final orderBy = '${CustomerFields.name} ASC';
    final result = await db.query(tableCustomers);
    return result.map((json) => Customer.fromJson(json)).toList();
  }
  Future<int> update(Customer customer) async {
    final db = await instance.database;

    return db.update(
      tableCustomers,
      customer.toJson(),
      where: '${CustomerFields.id} = ?',
      whereArgs: [customer.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableCustomers,
      where: '${CustomerFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}






