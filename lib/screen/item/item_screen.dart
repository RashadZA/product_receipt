import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:product_receipt/db/item_database.dart';
import 'package:product_receipt/helper/appBar_helper.dart';
import 'package:product_receipt/helper/drawer_helper.dart';
import 'package:product_receipt/model/item.dart';
import 'package:product_receipt/screen/item/add_Item_screen.dart';
import 'package:product_receipt/screen/item/item_details_screen.dart';
import 'package:product_receipt/widgets/item_widgets/item_card_widget.dart';
class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);
  static const String id = 'item_screen';

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  late List<Item> items;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshItems();
  }

  @override
  void dispose() {
    ItemsDatabase.instance.close();

    super.dispose();
  }

  Future refreshItems() async {
    setState(() => isLoading = true);

    items = await ItemsDatabase.instance.readAllItem();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context)  => Scaffold(
    appBar: CustomAppBar.customAppBar(context, 'Item'),
    drawer: CustomDrawer.customDrawer(context),
    body: Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : items.isEmpty
          ? const Text(
        'No Item',
        style: TextStyle(color: Colors.greenAccent, fontSize: 24),
      )
          : buildItems(),
    ),

    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.pushNamed(context, AddItemScreen.id);
        refreshItems();
      },

    ),
  );

  Widget buildItems() => StaggeredGridView.countBuilder(
    padding: const EdgeInsets.all(8),
    itemCount: items.length,
    staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final item = items[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ItemDetailsScreen(customerId: item.id!),
          ));

          refreshItems();
        },
        child: ItemCardWidget(item: item, index: index),
      );
    },
  );
}