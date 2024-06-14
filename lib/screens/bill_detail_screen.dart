import 'package:ceb_app/utils/color_utils.dart';
import 'package:flutter/material.dart';

class BillDetail extends StatefulWidget {
  const BillDetail({Key? key}) : super(key: key);

  @override
  State<BillDetail> createState() => _BillDetailState();
}

class _BillDetailState extends State<BillDetail> {
  // Hardcoded values for demo purposes
  final String accountNumber = "1234567890";
  final String accountOwnerName = "John Doe";
  final String readOn = "2024-06-01";
  final String meterReading = "34567 kWh";
  final String monthlyBill = "\Rs.120.00";
  final String otherCharges = "\Rs.15.00";
  final String openingBalance = "\Rs.50.00";
  final String totalPayable = "\Rs.185.00";
  final String dueDate = "2024-06-20";
  final String lastPayment = "\Rs.100.00 on 2024-05-30";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFD400),
        elevation: 0,
        title: const Text(
          "Ceylon Electricity Board",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: hexStringToColor("720F11"),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              120,
              20,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "Your Bill Details",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity, // Full width for the card
                  height: 400, // Adjust height as needed
                  child: Card(
                    color: Colors.white, // White background for the card
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Account number: $accountNumber",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Account owner name: $accountOwnerName",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Read on: $readOn",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Meter reading: $meterReading",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Monthly bill: $monthlyBill",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Other charges: $otherCharges",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Opening balance: $openingBalance",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Total payable: $totalPayable",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Due date: $dueDate",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Last payment: $lastPayment",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow, // Button color
                  ),
                  onPressed: () {
                    // Add navigation or functionality here
                  },
                  child: ListTile(
                    title: Center(child: Text('Continue to payment')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
