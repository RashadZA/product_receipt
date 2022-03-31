import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:product_receipt/db/invoice_database.dart';
import 'package:product_receipt/helper/appBar_helper.dart';
import 'package:product_receipt/helper/drawer_helper.dart';
import 'package:product_receipt/model/invoice.dart';
import 'package:product_receipt/screen/invoice/add_invoice_screen.dart';
import 'package:product_receipt/screen/invoice/invoice_details_screen.dart';
import 'package:product_receipt/widgets/invoice_widgets/invoice_card_widgets.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);
  static const String id = 'invoice_screen';

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {

  late List<Invoice> invoices;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() => isLoading = true);

    refreshCustomers();
  }

  @override
  void dispose() {
    InvoicesDatabase.instance.close();

    super.dispose();
  }

  Future refreshCustomers() async {


    invoices = await InvoicesDatabase.instance.readAllInvoice();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppBar.customAppBar(context, 'Invoice'),
    drawer: CustomDrawer.customDrawer(context),
    body: Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : invoices.isEmpty
          ? const Text(
        'No Invoice',
        style: TextStyle(color: Colors.greenAccent, fontSize: 24),
      )
          : buildCustomers(),
    ),

    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.pushNamed(context, AddInvoiceScreen.id);
        refreshCustomers();
      },

    ),
  );

  Widget buildCustomers() => StaggeredGridView.countBuilder(
    padding: const EdgeInsets.all(8),
    itemCount: invoices.length,
    staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final invoice = invoices[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InvoiceDetailsScreen(invoiceId: invoice.id!),
          ));

          refreshCustomers();
        },
        child: InvoiceCardWidget(invoice: invoice, index: index),
      );
    },
  );
}
