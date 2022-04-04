import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_receipt/model/expense.dart';

class ExpenseScreenCardWidget extends StatelessWidget {


  late Expense expense;

  @override
  Widget build(BuildContext context) {

    Text customTextOne(newText) => Text('$newText',
        style: const TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold));

    Text customTextTwo(newText) => Text('$newText',
        style: const TextStyle(
            fontSize: 15,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold));

    return Scaffold(
      body: Container(
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
                          customTextTwo(DateFormat.yMMMd().format(expense.expenseDate)),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextTwo(expense.expenseType),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextTwo('${expense.expenseAmount} /-'),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
