import 'package:flutter/material.dart';
import 'package:product_receipt/db/expense_database.dart';
import 'package:product_receipt/helper/appBar_helper.dart';
import 'package:product_receipt/helper/drawer_helper.dart';
import 'package:product_receipt/model/expense.dart';
import 'package:product_receipt/screen/expense/add_expense_screen.dart';
import 'package:product_receipt/screen/expense/expense_details_screen.dart';
import 'package:product_receipt/widgets/expense_widgets/expense_card_widget.dart';
class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);
  static const String id = 'expense_screen';

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  late List<Expense> expenses;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshExpenses();
  }

  @override
  void dispose() {
    ExpensesDatabase.instance.close();

    super.dispose();
  }

  Future refreshExpenses() async {
    setState(() => isLoading = true);

    expenses = await ExpensesDatabase.instance.readAllExpenses();

    setState(() => isLoading = false);
  }



  // var _addCard = 0;
  // void _incrementCard()
  // {
  //   setState(()
  //   {
  //     _addCard++ ;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context, 'Manage Expenses'),
      drawer: CustomDrawer.customDrawer(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
          );
          refreshExpenses();
        },
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : expenses.isEmpty
            ? const Text(
          'No Expense',
          style: TextStyle(color: Colors.green, fontSize: 24),
        )
            : buildExpenses(),
      ),
    );
  }
  Widget buildExpenses() => ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index){
        final expense = expenses[index];
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ExpenseDetailsScreen(expenseId: expense.id!),
            ));

            refreshExpenses();
          },
          child: ExpenseCardWidget(expense: expense, index: index),
        );
      }
  );
}


