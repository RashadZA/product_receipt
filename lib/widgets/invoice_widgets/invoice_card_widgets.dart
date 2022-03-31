import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_receipt/model/invoice.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class InvoiceCardWidget extends StatelessWidget {
  const InvoiceCardWidget({
    Key? key,
    required this.invoice,
    required this.index,
  }) : super(key: key);

  final Invoice invoice;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    // final time = DateFormat.yMMMd().format(customer.createdTime);
    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMd().format(invoice.createdTime),
              style: const TextStyle(color: Colors.greenAccent),
            ),
            Text(
              'Customer Name: ${invoice.customerName}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Item Name: ${invoice.itemName}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Item QTY: ${invoice.itemQTY}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Item Rate: ${invoice.itemRate}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total Item: ${invoice.totalItem}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total QTY: ${invoice.totalQTY}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total Rate: ${invoice.totalRate}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
    //   Card(
    //   color: color,
    //   child: Container(
    //     constraints: BoxConstraints(minHeight: minHeight),
    //     padding: const EdgeInsets.all(8),
    //     child: Column(
    //       children: [
    //         Column(
    //           children: [
    //             Expanded(
    //               child: Row(
    //                 children: [
    //                   const Expanded(
    //                     child: Text('Customer Details',
    //                       style: TextStyle(
    //                           color: Colors.greenAccent,
    //                           backgroundColor: Colors.black12,
    //                           fontWeight: FontWeight.bold
    //                       ),),
    //                   ),
    //                   Expanded(
    //                     child: Text(invoice.customerName,style: TextStyle(
    //                         color: Colors.greenAccent,
    //                         backgroundColor: Colors.black12
    //                     ),),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const Expanded(
    //               child: Text('Item Details',
    //                 style: TextStyle(
    //                     color: Colors.blueGrey,
    //                     backgroundColor: Colors.black12,
    //                     fontWeight: FontWeight.bold
    //                 ),),
    //             ),
    //             Expanded(
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   Text(invoice.itemName,style: const TextStyle(
    //                       color: Colors.blueGrey,
    //                       backgroundColor: Colors.black12
    //                   ),),
    //                   Text(invoice.totalQTY ,style: const TextStyle(
    //                       color: Colors.blueGrey,
    //                       backgroundColor: Colors.black12
    //                   ),),
    //                   Text(invoice.itemRate,style: const TextStyle(
    //                       color: Colors.blueGrey,
    //                       backgroundColor: Colors.black12
    //                   ),),
    //                 ],
    //               ),
    //             ),
    //             const Expanded(
    //               child: Text('Grand Total',
    //                 style: TextStyle(
    //                     color: Colors.blueAccent,
    //                     backgroundColor: Colors.black12,
    //                     fontWeight: FontWeight.bold
    //                 ),),
    //             ),
    //             Expanded(
    //               child:  Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   Text(invoice.totalItem as String,style: const TextStyle(
    //                       color: Colors.blueAccent,
    //                       backgroundColor: Colors.black12
    //                   ),),
    //                   Text(invoice.totalQTY as String,style: const TextStyle(
    //                       color: Colors.blueAccent,
    //                       backgroundColor: Colors.black12
    //                   ),),
    //                   Text(invoice.totalRate as String,style: const TextStyle(
    //                       color: Colors.blueAccent,
    //                       backgroundColor: Colors.black12
    //                   ),),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
