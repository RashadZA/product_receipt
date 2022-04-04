import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_receipt/helper/custom_theme.dart';

class InvoiceFormWidget extends StatelessWidget {
  final String customerName;
  final String itemName;
  final String itemRate;
  final String itemQTY;
  final String totalItem;
  final String totalQTY;
  final String totalRate;
  final ValueChanged<String> onChangedCustomerName;
  final ValueChanged<String> onChangedItemName;
  final ValueChanged<String> onChangedItemRate;
  final ValueChanged<String> onChangedItemQTY;
  final ValueChanged<String> onChangedTotalItem;
  final ValueChanged<String> onChangedTotalQTY;
  final ValueChanged<String> onChangedTotalRate;
  const InvoiceFormWidget({
    Key? key,
    this.customerName = '',
    this.itemName = '',
    this.itemRate = '',
    this.itemQTY = '',
    this.totalItem = '',
    this.totalQTY = '',
    this.totalRate = '',
    required this.onChangedCustomerName,
    required this.onChangedItemName,
    required this.onChangedItemRate,
    required this.onChangedItemQTY,
    required this.onChangedTotalItem,
    required this.onChangedTotalQTY,
    required this.onChangedTotalRate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Column(
          //   children: [
          //     Expanded(
          //       child: Row(
          //         children: [
          //           const Expanded(
          //             child: Text('Customer Details',
          //               style: TextStyle(
          //                   color: Colors.greenAccent,
          //                   backgroundColor: Colors.black12,
          //                   fontWeight: FontWeight.bold
          //               ),),
          //           ),
          //           Expanded(
          //             child: Text(invoice.customerName,style: TextStyle(
          //                 color: Colors.greenAccent,
          //                 backgroundColor: Colors.black12
          //             ),),
          //           ),
          //         ],
          //       ),
          //     ),
          //     const Expanded(
          //       child: Text('Item Details',
          //         style: TextStyle(
          //             color: Colors.blueGrey,
          //             backgroundColor: Colors.black12,
          //             fontWeight: FontWeight.bold
          //         ),),
          //     ),
          //     Expanded(
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Text(invoice.itemName,style: const TextStyle(
          //               color: Colors.blueGrey,
          //               backgroundColor: Colors.black12
          //           ),),
          //           Text(invoice.totalQTY as String,style: const TextStyle(
          //               color: Colors.blueGrey,
          //               backgroundColor: Colors.black12
          //           ),),
          //           Text(invoice.itemRate,style: const TextStyle(
          //               color: Colors.blueGrey,
          //               backgroundColor: Colors.black12
          //           ),),
          //         ],
          //       ),
          //     ),
          //     const Expanded(
          //       child: Text('Grand Total',
          //         style: TextStyle(
          //             color: Colors.blueAccent,
          //             backgroundColor: Colors.black12,
          //             fontWeight: FontWeight.bold
          //         ),),
          //     ),
          //     Expanded(
          //       child:  Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Text(invoice.totalItem as String,style: const TextStyle(
          //               color: Colors.blueAccent,
          //               backgroundColor: Colors.black12
          //           ),),
          //           Text(invoice.totalQTY as String,style: const TextStyle(
          //               color: Colors.blueAccent,
          //               backgroundColor: Colors.black12
          //           ),),
          //           Text(invoice.totalRate as String,style: const TextStyle(
          //               color: Colors.blueAccent,
          //               backgroundColor: Colors.black12
          //           ),),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),

          buildCustomerName(),
          const SizedBox(height: 8),
          buildItemName(),
          const SizedBox(height: 8),
          buildItemRate(),
          const SizedBox(height: 16),
          buildItemQTY(),
          const SizedBox(height: 16),
          buildTotalItem(),
          const SizedBox(height: 16),
          buildTotalQTY(),
          const SizedBox(height: 16),
          buildTotalRate(),
        ],
      ),
    ),
  );

  Widget buildCustomerName() => TextFormField(
    maxLines: 1,
    initialValue: customerName,
    style: const TextStyle(
      color: Colors.greenAccent,
      fontSize: 24,
    ),
    decoration: CustomTheme()
        .textInputDecoration("Customer Name", "Enter Name"),
    validator: (customerName) =>
    customerName != null && customerName.isEmpty ? 'The Customer Name cannot be empty' : null,
    onChanged: onChangedCustomerName,
  );

  Widget buildItemName() => TextFormField(
    maxLines: 2,
    initialValue: itemName,
    style: const TextStyle(color: Colors.greenAccent, fontSize: 18),
    decoration: CustomTheme()
        .textInputDecoration("Item Name", "Enter Name"),
    validator: (itemName) => itemName != null && itemName.isEmpty
        ? 'The Item Name cannot be empty'
        : null,
    onChanged: onChangedItemName,
  );

  Widget buildItemRate() => TextFormField(
    keyboardType: TextInputType.phone,
    maxLines: 1,
    initialValue: itemRate,
    style: const TextStyle(
      color: Colors.greenAccent,
      fontSize: 24,
    ),
    decoration: CustomTheme()
        .textInputDecoration("Item Rate", "Enter Rate"),
    validator: (itemRate) =>
    itemRate != null && itemRate.isEmpty ? 'The Item Rate cannot be empty' : null,
    onChanged: onChangedItemRate,
  );

  Widget buildItemQTY() => TextFormField(
    keyboardType: TextInputType.phone,
    maxLines: 1,
    initialValue: itemQTY,
    style: const TextStyle(color: Colors.greenAccent, fontSize: 18),
    decoration: CustomTheme()
        .textInputDecoration("Item QTY", "Enter  QTY"),
    validator: (itemQTY) => itemQTY != null && itemQTY.isEmpty
        ? 'The Item QTY cannot be empty'
        : null,
    onChanged: onChangedItemQTY,
  );

  Widget buildTotalItem() => TextFormField(
    keyboardType: TextInputType.phone,
    maxLines: 1,
    initialValue: totalItem,
    style: const TextStyle(color: Colors.greenAccent, fontSize: 18),
    decoration: CustomTheme()
        .textInputDecoration("Total Item", "Enter  Total"),
    validator: (totalItem) => totalItem != null && totalItem.isEmpty
        ? 'The Total Item cannot be empty'
        : null,
    onChanged: onChangedTotalItem,
  );

  Widget buildTotalQTY() => TextFormField(
    keyboardType: TextInputType.phone,
    maxLines: 1,
    initialValue: totalQTY,
    style: const TextStyle(color: Colors.greenAccent, fontSize: 18),
    decoration: CustomTheme()
        .textInputDecoration("Total QTY", "Enter  QTY"),
    validator: (totalQTY) => totalQTY != null && totalQTY.isEmpty
        ? 'The Total QTY cannot be empty'
        : null,
    onChanged: onChangedTotalQTY,
  );

  Widget buildTotalRate() => TextFormField(
    keyboardType: TextInputType.phone,
    maxLines: 1,
    initialValue: totalRate,
    style: const TextStyle(color: Colors.greenAccent, fontSize: 18),
    decoration: CustomTheme()
        .textInputDecoration("Total Rate", "Enter  Rate"),
    validator: (totalRate) => totalRate != null && totalRate.isEmpty
        ? 'The Total Rate cannot be empty'
        : null,
    onChanged: onChangedTotalRate,
  );
}