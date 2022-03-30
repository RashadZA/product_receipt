import 'package:flutter/material.dart';
import 'package:product_receipt/model/item.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final Item item;
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
              'Item Name: ${item.name}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Code: ${item.code}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Rate: ${item.rate}',
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
