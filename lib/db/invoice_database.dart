import 'package:path/path.dart';
import 'package:product_receipt/model/invoice.dart';
import 'package:sqflite/sqflite.dart';


class InvoicesDatabase {
  InvoicesDatabase._init();
  static final InvoicesDatabase instance = InvoicesDatabase._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('invoice.db');

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
    CREATE TABLE $tableInvoices (
    ${InvoiceFields.id} $idType,
    ${InvoiceFields.time} $textType,
    ${InvoiceFields.customerName} $textType,
    ${InvoiceFields.itemName} $textType,
    ${InvoiceFields.itemRate} $textType,
    ${InvoiceFields.itemQTY} $textType,
    ${InvoiceFields.totalItem} $textType,
    ${InvoiceFields.totalQTY} $textType,
    ${InvoiceFields.totalRate} $textType
    )
    ''');
  }

  Future<Invoice> create(Invoice invoice) async {
    final db = await instance.database;


    final id = await db.insert(tableInvoices, invoice.toJson());
    return invoice.copy(id: id);
  }

  Future<Invoice> readInvoice(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableInvoices,
      columns: InvoiceFields.values,
      where: '${InvoiceFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return Invoice.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id not found');
    }

  }


  Future<List<Invoice>> readAllInvoice() async{
    final db = await instance.database;

    // final orderBy = '${CustomerFields.name} ASC';
    final result = await db.query(tableInvoices);
    return result.map((json) => Invoice.fromJson(json)).toList();
  }
  Future<int> update(Invoice invoice) async {
    final db = await instance.database;

    return db.update(
      tableInvoices,
      invoice.toJson(),
      where: '${InvoiceFields.id} = ?',
      whereArgs: [invoice.id]
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableInvoices,
      where: '${InvoiceFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}






