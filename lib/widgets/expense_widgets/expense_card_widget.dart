import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_receipt/model/expense.dart';


class ExpenseCardWidget extends StatelessWidget {
  ExpenseCardWidget({
    Key? key,
    required this.expense,
    required this.index,
  }) : super(key: key);

  final Expense expense;
  final int index;

  String amount = '5000';
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
    final time = DateFormat.yMMMd().format(expense.expenseDate);

    return Container(
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
                        customTextTwo(time),
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
    );

    //   Card(
    //   color: color,
    //   child: Container(
    //     constraints: BoxConstraints(minHeight: minHeight),
    //     padding: EdgeInsets.all(8),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           time,
    //           style: TextStyle(color: Colors.grey.shade700),
    //         ),
    //         SizedBox(height: 4),
    //         Text(
    //           'Title: ${expense.expenseAmount}',
    //           style: TextStyle(
    //             color: Colors.black,
    //             fontSize: 20,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         SizedBox(height: 8),
    //         Text(
    //           expense.expenseAmount,
    //           style: TextStyle(
    //             color: Colors.black,
    //             fontSize: 20,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}