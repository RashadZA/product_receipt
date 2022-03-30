import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:product_receipt/db/customer_database.dart';
import 'package:product_receipt/helper/appBar_helper.dart';
import 'package:product_receipt/helper/drawer_helper.dart';
import 'package:product_receipt/model/customer.dart';
import 'package:product_receipt/screen/customer/add_customer_screen.dart';
import 'package:product_receipt/screen/customer/customer_details_screen.dart';
import 'package:product_receipt/widgets/customer_widgets/customer_card_widget.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);
  static const String id = 'customer_screen';

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {

  late List<Customer> customers;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() => isLoading = true);

    refreshCustomers();
  }

  @override
  void dispose() {
    CustomersDatabase.instance.close();

    super.dispose();
  }

  Future refreshCustomers() async {


    customers = await CustomersDatabase.instance.readAllCustomer();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppBar.customAppBar(context, 'Customer'),
    drawer: CustomDrawer.customDrawer(context),
        body: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : customers.isEmpty
                ? const Text(
              'No Customer',
              style: TextStyle(color: Colors.greenAccent, fontSize: 24),
            )
                : buildCustomers(),
          ),

    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.pushNamed(context, AddCustomerScreen.id);
        refreshCustomers();
      },

    ),
      );

  Widget buildCustomers() => StaggeredGridView.countBuilder(
    padding: const EdgeInsets.all(8),
    itemCount: customers.length,
    staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final customer = customers[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CustomerDetailsScreen(customerId: customer.id!),
          ));

          refreshCustomers();
        },
        child: CustomerCardWidget(customer: customer, index: index),
      );
    },
  );
}
