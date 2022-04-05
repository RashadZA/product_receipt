import 'package:flutter/material.dart';
import 'package:product_receipt/db/customer_database.dart';
import 'package:product_receipt/helper/appBar_helper.dart';
import 'package:product_receipt/model/customer.dart';
import 'package:product_receipt/widgets/customer_widgets/customer_form_widdget.dart';
import 'package:product_receipt/widgets/header_widget.dart';

class AddCustomerScreen extends StatefulWidget {
  final Customer? customer;
  const AddCustomerScreen({Key? key, this.customer}) : super(key: key);
  static const String id = 'add_customer_screen';

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  // final _nameEditingController = TextEditingController();
  // final _mobileNoEditingController = TextEditingController();
  // final _emailEditingController = TextEditingController();

  late String name;
  late String number;
  late String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.customer?.name ?? '';
    number = widget.customer?.number ?? '';
    email = widget.customer?.email ?? '';
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar.customAppBar(context, 'Add Customer'),
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
                    child: CustomerFormWidget(
                      name: name,
                      number: number,
                      email: email,
                      onChangedName: (name) => setState(() => this.name = name),
                      onChangedNumber: (number) => setState(() => this.number = number),
                      onChangedEmail: (email) => setState(() => this.email = email),

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
    final isFormValid = name.isNotEmpty && number.isNotEmpty && email.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateCustomer,
        child: const Text('Save'),
      ),
    );
  }
  void addOrUpdateCustomer() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.customer != null;

      if (isUpdating) {
        await updateCustomer();
      } else {
        await addCUstomer();
      }
      Navigator.of(context).pop();
      // Navigator.pushNamed(context, CustomerScreen.id);
    }
  }

  Future updateCustomer() async {
    final customer = widget.customer!.copy(
      name: name,
      number: number,
      email: email,
    );

    await CustomersDatabase.instance.update(customer);
  }

  Future addCUstomer() async {
    final customer = Customer(
      name: name,
      number: number,
      email: email,
    );

    await CustomersDatabase.instance.create(customer);
  }

}
