import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_receipt/db/expense_database.dart';
import 'package:product_receipt/helper/appBar_helper.dart';
import 'package:product_receipt/helper/drawer_helper.dart';
import 'package:product_receipt/model/expense.dart';
import 'package:product_receipt/screen/expense/add_expense_screen.dart';
class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);
  static const String id = 'expense_screen';

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  late List<Expense> expenses;
  // bool isLoading = false;
  //
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
    // setState(() => isLoading = true);

    expenses = await ExpensesDatabase.instance.readAllExpenses();
    setState(() {

    });

    // setState(() => isLoading = false);
  }

   customTextOne(newText) => Text('$newText',
      style: const TextStyle(
          fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold));

   customTextTwo(newText) => Text('$newText',
      style: const TextStyle(
          fontSize: 15,
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context, 'Manage Expenses'),
      drawer: CustomDrawer.customDrawer(context),
      body:Container(
        color: Colors.white,
        child: Card(
          elevation: 8,
          shadowColor: Colors.green,
          margin: const EdgeInsets.all(20),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          // shape:  ShapeBorder(
          //     borderRadius: BorderRadius.circular(10),
          //     borderSide: BorderSide(color: Colors.green, width: 1)
          // ),
          child: ClipPath(
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                border:  Border(left: BorderSide(color: Colors.blueAccent, width: 10)),
                color: Colors.white,
              ),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 30, 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customTextOne('Expense Date '),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextOne('Expense Type '),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextOne('Amount '),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customTextTwo(DateFormat.yMMMd().format(expenses.expenseDate)),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextTwo(expenses.expenseType),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextTwo('${expenses.expenseAmount} /-'),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
      // Center(
      //     child: isLoading
      //         ? const CircularProgressIndicator()
      //         : expenses.isEmpty
      //         ? const Text(
      //       'No Customer',
      //       style: TextStyle(color: Colors.greenAccent, fontSize: 24),
      //     )
      //         : ExpenseScreenCardWidget()
      // ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
      ),
    );
  }
}
