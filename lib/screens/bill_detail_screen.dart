import 'package:ceb_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BillDetail extends StatefulWidget {
  final String accountNumber;
  final String month;

  const BillDetail({Key? key, required this.accountNumber, required this.month})
      : super(key: key);

  @override
  State<BillDetail> createState() => _BillDetailState();
}

class _BillDetailState extends State<BillDetail> {
  Map<String, dynamic> billData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBillDetails();
  }

  void fetchBillDetails() async {
    try {
      DocumentSnapshot billSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.accountNumber)
          .collection('meterReadings')
          .doc(widget.month)
          .get();

      if (billSnapshot.exists) {
        setState(() {
          billData = billSnapshot.data() as Map<String, dynamic>;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching bill details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
  }

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
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                        child: Card(
                          color: Colors.white, // White background for the card
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Account number: ${widget.accountNumber}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Read on: ${billData['readOn'] != null ? formatTimestamp(billData['readOn']) : 'N/A'}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Meter reading: ${billData['readingValue'] ?? 'N/A'}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Monthly bill: Rs.${billData['monthlyBill'] ?? 'N/A'}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Total payable: Rs.${billData['totalPayable'] ?? 'N/A'}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Due date: ${billData['dueDate'] != null ? formatTimestamp(billData['dueDate']) : 'N/A'}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 8),
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
