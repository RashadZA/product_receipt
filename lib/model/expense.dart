const String tableExpenses = 'expense';

class ExpenseFields {
  static final List<String> values = [
    //add al file
    id, time, expenseType, expenseAmount
  ];

  static const String id = '_id';
  static const String time = 'expenseDate';
  static const String expenseType = 'expenseType';
  static const String expenseAmount = 'expenseAmount';
}

class Expense {
  final int? id;
  final DateTime expenseDate;
  final String expenseType;
  final String expenseAmount;

  const Expense(
      {this.id,
      required this.expenseDate,
      required this.expenseType,
      required this.expenseAmount});

  Expense copy(
          {int? id,
          DateTime? expenseDate,
          String? expenseType,
          String? expenseAmount}) =>
      Expense(
          id: id ?? this.id,
          expenseDate: expenseDate ?? this.expenseDate,
          expenseType: expenseType ?? this.expenseType,
          expenseAmount: expenseAmount ?? this.expenseAmount
      );

  static Expense fromJson(Map<String, Object?> json) => Expense(
      id: json[ExpenseFields.id] as int?,
      expenseDate: DateTime.parse(json[ExpenseFields.time] as String),
      expenseType: json[ExpenseFields.expenseType] as String,
      expenseAmount: json[ExpenseFields.expenseAmount] as String
  );
  Map<String, Object?> toJson() => {
    ExpenseFields.id: id,
    ExpenseFields.time: expenseDate.toIso8601String(),
    ExpenseFields.expenseType: expenseType,
    ExpenseFields.expenseAmount: expenseAmount
  };
}
