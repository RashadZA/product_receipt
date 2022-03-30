import 'package:flutter/material.dart';
import 'package:product_receipt/db/item_database.dart';
import 'package:product_receipt/model/item.dart';
import 'package:product_receipt/screen/item/add_Item_screen.dart';
import 'package:product_receipt/screen/item/item_screen.dart';
class ItemDetailsScreen extends StatefulWidget {
  final int customerId;

  const ItemDetailsScreen({
    Key? key,
    required this.customerId,
  }) : super(key: key);

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  late Item item;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshItem();
  }

  Future refreshItem() async {
    setState(() => isLoading = true);

    item = await ItemsDatabase.instance.readItem(widget.customerId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
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
            'Item Name: ${item.name}',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Code : ${item.code}',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Rate: ${item.rate}',
            style: const TextStyle(color: Colors.greenAccent, fontSize: 18),
          )
        ],
      ),
    ),
  );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddItemScreen(item: item),
        ));

        refreshItem();
      });

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await ItemsDatabase.instance.delete(widget.customerId);

      Navigator.pushNamed(context, ItemScreen.id);
    },
  );
}