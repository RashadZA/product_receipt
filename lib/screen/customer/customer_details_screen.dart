import 'package:flutter/material.dart';
import 'package:product_receipt/db/customer_database.dart';
import 'package:product_receipt/model/customer.dart';
import 'package:product_receipt/screen/customer/add_customer_screen.dart';
import 'package:product_receipt/screen/customer/customer_screen.dart';
class CustomerDetailsScreen extends StatefulWidget {
  final int customerId;

  const CustomerDetailsScreen({
    Key? key,
    required this.customerId,
  }) : super(key: key);

  @override
  _CustomerDetailsScreenState createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  late Customer customer;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshCustomer();
  }

  Future refreshCustomer() async {
    setState(() => isLoading = true);

    customer = await CustomersDatabase.instance.readCustomer(widget.customerId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Customer Details'),
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
                'Customer Name: ${customer.name}',
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Mobile No. : ${customer.number}',
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Email: ${customer.email}',
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
          builder: (context) => AddCustomerScreen(customer: customer),
        ));

        refreshCustomer();
      });

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await CustomersDatabase.instance.delete(widget.customerId);

      Navigator.pushNamed(context, CustomerScreen.id);
    },
  );
}