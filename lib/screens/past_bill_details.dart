import 'package:ceb_app/screens/bill_detail_screen.dart';
import 'package:ceb_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PastBillDetails extends StatefulWidget {
  final String accountNumber;

  const PastBillDetails({Key? key, required this.accountNumber})
      : super(key: key);

  @override
  State<PastBillDetails> createState() => _PastBillDetailsState();
}

class _PastBillDetailsState extends State<PastBillDetails> {
  List<String> billMonths = [];

  @override
  void initState() {
    super.initState();
    fetchBillMonths();
  }

  void fetchBillMonths() async {
    try {
      QuerySnapshot billSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.accountNumber)
          .collection('meterReadings')
          .get();

      setState(() {
        billMonths = billSnapshot.docs.map((doc) => doc.id).toList();
      });
    } catch (e) {
      print("Error fetching bill months: $e");
    }
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              120,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Past Bill Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                ...billMonths.map((month) => Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BillDetail(
                                        accountNumber: widget.accountNumber,
                                        month: month,
                                      )),
                            );
                          },
                          child: ListTile(
                            title: Center(child: Text(month)),
                          ),
                        ),
                        SizedBox(height: 20), // Add space between buttons
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
