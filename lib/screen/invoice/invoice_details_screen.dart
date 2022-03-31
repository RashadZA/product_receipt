import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_receipt/db/invoice_database.dart';
import 'package:product_receipt/model/invoice.dart';
import 'package:product_receipt/screen/invoice/add_invoice_screen.dart';
import 'package:product_receipt/screen/invoice/invoice_screen.dart';
class InvoiceDetailsScreen extends StatefulWidget {
  final int invoiceId;

  const InvoiceDetailsScreen({
    Key? key,
    required this.invoiceId,
  }) : super(key: key);

  @override
  _InvoiceDetailsScreenState createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  late Invoice invoice;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshInvoice();
  }

  Future refreshInvoice() async {
    setState(() => isLoading = true);

    invoice = await InvoicesDatabase.instance.readInvoice(widget.invoiceId);

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
            DateFormat.yMMMd().format(invoice.createdTime),
            style: const TextStyle(color: Colors.greenAccent),
          ),
          Text(
            'Customer Name: ${invoice.customerName}',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Customer Name: ${invoice.customerName}',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Item Name: ${invoice.itemName}',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Item QTY: ${invoice.itemQTY}',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Item Rate: ${invoice.itemRate}',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total Item : ${invoice.totalItem}',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Total QTY: ${invoice.totalQTY}',
            style: const TextStyle(color: Colors.greenAccent, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Total Rate: ${invoice.totalRate}',
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
          builder: (context) => AddInvoiceScreen(invoice: invoice),
        ));

        refreshInvoice();
      });

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await InvoicesDatabase.instance.delete(widget.invoiceId);

      Navigator.pushNamed(context, InvoiceScreen.id);
    },
  );
}