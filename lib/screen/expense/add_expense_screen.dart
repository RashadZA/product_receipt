import 'package:flutter/material.dart';
import 'package:product_receipt/db/expense_database.dart';
import 'package:product_receipt/model/expense.dart';
import 'package:product_receipt/widgets/expense_widgets/expense_form_widget.dart';
class AddExpenseScreen extends StatefulWidget {
  final Expense? expense;
  const AddExpenseScreen({Key? key, this.expense}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  late String expenseType;
  late String expenseAmount;
  @override
  void initState() {
    super.initState();

    expenseType = widget.expense?.expenseType ?? '';
    expenseAmount = widget.expense?.expenseAmount ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: ExpenseFormWidget(
       expenseType: expenseType,
        expenseAmount: expenseAmount,
        onChangedExpenseType: (expenseType) =>
            setState(() => this.expenseType = expenseType),
        onChangedExpenseAmount: (expenseAmount) => setState(() => this.expenseAmount = expenseAmount),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = expenseType.isNotEmpty && expenseAmount.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateExpense,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateExpense() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.expense != null;

      if (isUpdating) {
        await updateExpense();
      } else {
        await addExpense();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateExpense() async {
    final expense = widget.expense!.copy(
      expenseType: expenseType,
      expenseAmount: expenseAmount
    );

    await ExpensesDatabase.instance.update(expense);
  }

  Future addExpense() async {
    final expense = Expense(
      expenseDate: DateTime.now(),
      expenseType: expenseType,
      expenseAmount: expenseAmount
    );

    await ExpensesDatabase.instance.create(expense);
  }
}