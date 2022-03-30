import 'package:flutter/material.dart';
import 'package:product_receipt/db/item_database.dart';
import 'package:product_receipt/helper/appBar_helper.dart';
import 'package:product_receipt/model/item.dart';
import 'package:product_receipt/widgets/header_widget.dart';
import 'package:product_receipt/widgets/item_widgets/item_form_widget.dart';
class AddItemScreen extends StatefulWidget {
  final Item? item;
  const AddItemScreen({Key? key, this.item}) : super(key: key);
  static const String id = 'add_item_screen';

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String code;
  late String rate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.item?.name ?? '';
    code = widget.item?.code ?? '';
    rate = widget.item?.rate ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context, 'Add Item'),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.add_shopping_cart),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 200, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: ItemFormWidget(
                      name: name,
                      code: code,
                      rate: rate,
                      onChangedName: (name) => setState(() => this.name = name),
                      onChangedCode: (code) => setState(() => this.code = code),
                      onChangedRate: (rate) => setState(() => this.rate = rate),

                    ),
                  ),
                  const SizedBox(height: 8),
                  buildButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildButton() {
    final isFormValid = name.isNotEmpty && code.isNotEmpty && rate.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateItem,
        child: const Text('Save'),
      ),
    );
  }
  void addOrUpdateItem() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.item != null;

      if (isUpdating) {
        await updateItem();
      } else {
        await addNote();
      }
      Navigator.of(context).pop();
      // Navigator.pushNamed(context, CustomerScreen.id);
    }
  }

  Future updateItem() async {
    final item = widget.item!.copy(
      name: name,
      code: code,
      rate: rate,
    );

    await ItemsDatabase.instance.update(item);
  }

  Future addNote() async {
    final item = Item(
      name: name,
      code: code,
      rate: rate,
    );

    await ItemsDatabase.instance.create(item);
  }

}

