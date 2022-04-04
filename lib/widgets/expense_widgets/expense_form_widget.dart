import 'package:flutter/material.dart';
import 'package:product_receipt/helper/custom_theme.dart';
class ExpenseFormWidget extends StatelessWidget {
  final String? expenseType;
  final String? expenseAmount;
  final ValueChanged<String> onChangedExpenseType;
  final ValueChanged<String> onChangedExpenseAmount;

  const ExpenseFormWidget({
    Key? key,
    this.expenseType = '',
    this.expenseAmount = '',
    required this.onChangedExpenseType,
    required this.onChangedExpenseAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildExpenseType(),
          const SizedBox(height: 8),
          buildExpenseAmount(),

        ],
      ),
    ),
  );

  Widget buildExpenseType() => TextFormField(
    maxLines: 1,
    initialValue: expenseType,
    style: const TextStyle(
      color: Colors.greenAccent,
      fontSize: 24,
    ),
    decoration: CustomTheme()
        .textInputDecoration("Expense Type", "Enter Expense Type"),
    validator: (title) =>
    title != null && title.isEmpty ? 'The Expense Type cannot be empty' : null,
    onChanged: onChangedExpenseType,
  );


  Widget buildExpenseAmount() => TextFormField(
    keyboardType: TextInputType.phone,
    maxLines: 1,
    initialValue: expenseAmount,
    style: const TextStyle(
      color: Colors.greenAccent,
      fontSize: 24,
    ),
    decoration: CustomTheme()
        .textInputDecoration("Expense Amount", "Enter Mobile Number"),
    validator: (title) =>
    title != null && title.isEmpty ? 'The Expense Amount cannot be empty' : null,
    onChanged: onChangedExpenseAmount,
  );

}