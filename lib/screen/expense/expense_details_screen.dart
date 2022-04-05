import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_receipt/db/expense_database.dart';
import 'package:product_receipt/model/expense.dart';
import 'package:product_receipt/screen/expense/add_expense_screen.dart';
class ExpenseDetailsScreen extends StatefulWidget {
  final int expenseId;
  const ExpenseDetailsScreen({Key? key, required this.expenseId}) : super(key: key);

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  late Expense expense;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    refreshExpense();
  }

  Future refreshExpense() async {
    setState(() => isLoading = true);

    expense = await ExpensesDatabase.instance.readExpense(widget.expenseId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Expense Details'),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).colorScheme.secondary,]
            )
        ),
      ),
      actions: [editButton(), deleteButton()],
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Expense Date: ${DateFormat.yMMMd().format(expense.expenseDate)}',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Expense Type : ${expense.expenseType}',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Expense Amount: ${expense.expenseAmount}',
            style: const TextStyle(color: Colors.greenAccent, fontSize: 18),
          )
        ],
      ),
    ),

    // Padding(
    //   padding: const EdgeInsets.all(12),
    //   child: ListView(
    //     padding: EdgeInsets.symmetric(vertical: 8),
    //     children: [
    //       Text(
    //         'Expe ${DateFormat.yMMMd().format(expense.expenseDate)}',
    //         style: TextStyle(color: Colors.blueAccent),
    //       ),
    //       SizedBox(height: 8),
    //       Text(
    //         expense.expenseType,
    //         style: TextStyle(
    //           color: Colors.blueAccent,
    //           fontSize: 22,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       SizedBox(height: 8),
    //       Text(
    //         expense.expenseAmount,
    //         style: TextStyle(color: Colors.blueAccent, fontSize: 18),
    //       )
    //     ],
    //   ),
    // ),
  );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddExpenseScreen(expense: expense,),
        ));

        refreshExpense();
      });

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await ExpensesDatabase.instance.delete(widget.expenseId);

      Navigator.of(context).pop();
    },
  );
}