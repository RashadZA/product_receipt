import 'package:flutter/material.dart';
import 'package:product_receipt/db/invoice_database.dart';
import 'package:product_receipt/helper/appBar_helper.dart';
import 'package:product_receipt/model/invoice.dart';
import 'package:product_receipt/widgets/header_widget.dart';
import 'package:product_receipt/widgets/invoice_widgets/invoice_form_widget.dart';

class AddInvoiceScreen extends StatefulWidget {
  final Invoice? invoice;
  const AddInvoiceScreen({Key? key, this.invoice}) : super(key: key);
  static const String id = 'add_invoice_screen';

  @override
  State<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  final _formKey = GlobalKey<FormState>();

  late String customerName;
  late String itemName;
  late String itemRate;
  late String itemQTY;
  late String totalItem;
  late String totalQTY;
  late String totalRate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customerName = widget.invoice?.customerName ?? '';
    itemName = widget.invoice?.itemName ?? '';
    itemRate = widget.invoice?.itemRate ?? '';
    itemQTY = widget.invoice?.itemQTY ?? '';
    totalItem = widget.invoice?.totalItem ?? '';
    totalQTY = widget.invoice?.totalQTY ?? '';
    totalRate = widget.invoice?.totalRate ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context, 'Add Invoice'),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 200, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: InvoiceFormWidget(
                      customerName: customerName,
                      itemName: itemName,
                      itemRate: itemRate,
                      itemQTY: itemQTY,
                      totalItem: totalItem,
                      totalQTY: totalQTY,
                      totalRate: totalRate,
                      onChangedCustomerName: (customerName) =>
                          setState(() => this.customerName = customerName),
                      onChangedItemName: (itemName) =>
                          setState(() => this.itemName = itemName),
                      onChangedItemQTY: (itemRate) =>
                          setState(() => this.itemRate = itemRate),
                      onChangedItemRate: (itemQTY) =>
                          setState(() => this.itemQTY = itemQTY),
                      onChangedTotalItem: (totalItem) =>
                          setState(() => this.totalItem = totalItem),
                      onChangedTotalQTY: (totalQTY) =>
                          setState(() => this.totalQTY = totalQTY),
                      onChangedTotalRate: (totalRate) =>
                          setState(() => this.totalRate = totalRate),
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
    final isFormValid = customerName.isNotEmpty &&
        itemName.isNotEmpty &&
        itemQTY.isNotEmpty &&
        itemRate.isNotEmpty &&
        totalItem.isNotEmpty &&
        totalQTY.isNotEmpty &&
        totalRate.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateInvoice,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateInvoice() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.invoice != null;

      if (isUpdating) {
        await updateInvoice();
      } else {
        await addInvoice();
      }
      Navigator.of(context).pop();
      // Navigator.pushNamed(context, CustomerScreen.id);
    }
  }

  Future updateInvoice() async {
    final invoice = widget.invoice!.copy(
        customerName: customerName,
        itemName: itemName,
        itemRate: itemRate,
        itemQTY: itemQTY,
        totalItem: totalItem,
        totalQTY: totalQTY,
        totalRate: totalRate);

    await InvoicesDatabase.instance.update(invoice);
  }

  Future addInvoice() async {
    final invoice = Invoice(
      createdTime: DateTime.now(),
      customerName: customerName,
      itemName: itemName,
      itemRate: itemRate,
      itemQTY: itemQTY,
      totalItem: totalItem,
      totalQTY: totalQTY,
      totalRate: totalRate
    );

    await InvoicesDatabase.instance.create(invoice);
  }
}
