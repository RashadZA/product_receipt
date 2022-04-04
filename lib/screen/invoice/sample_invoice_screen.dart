import 'package:flutter/material.dart';
import 'package:product_receipt/helper/appBar_helper.dart';
import 'package:product_receipt/model/invoice.dart';
class SampleInvoiceScreen extends StatefulWidget {
  final Invoice? invoice;
  const SampleInvoiceScreen({Key? key,  this.invoice}) : super(key: key);
  static const String id = 'sample_invoice_screen';

  @override
  State<SampleInvoiceScreen> createState() => _SampleInvoiceScreenState();
}

class _SampleInvoiceScreenState extends State<SampleInvoiceScreen> {
  // final _formKey = GlobalKey<FormState>();

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
            const EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  const [
                CircleAvatar(
                  child: Icon(
                    Icons.list,
                    size: 30,
                    color: Colors.lightBlueAccent,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Todoey',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '0 Tasks',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     decoration: const BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(20),
          //         topRight: Radius.circular(20),
          //       ),
          //     ),
          //     child: TasksList(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
