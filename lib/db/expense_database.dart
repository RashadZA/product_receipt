import 'package:path/path.dart';
import 'package:product_receipt/model/expense.dart';
import 'package:sqflite/sqflite.dart';

class ExpensesDatabase {
  ExpensesDatabase._init();
  static final ExpensesDatabase instance = ExpensesDatabase._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('expense.db');

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
    CREATE TABLE $tableExpenses (
    ${ExpenseFields.id} $idType,
    ${ExpenseFields.time} $textType,
    ${ExpenseFields.expenseType} $textType,
    ${ExpenseFields.expenseAmount} $textType
    )
    ''');
  }

  Future<Expense> create(Expense expense) async {
    final db = await instance.database;


    final id = await db.insert(tableExpenses, expense.toJson());
    return expense.copy(id: id);
  }

  Future<Expense> readExpense(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableExpenses,
      columns: ExpenseFields.values,
      where: '${ExpenseFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return Expense.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id not found');
    }

  }


  Future<List<Expense>> readAllExpenses() async{
    final db = await instance.database;

    const orderBy = '${ExpenseFields.id} ASC';
    final result = await db.query(tableExpenses, orderBy: orderBy);
    return result.map((json) => Expense.fromJson(json)).toList();
  }
  Future<int> update(Expense expense) async {
    final db = await instance.database;

    return db.update(
      tableExpenses,
      expense.toJson(),
      where: '${ExpenseFields.id} = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableExpenses,
      where: '${ExpenseFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
