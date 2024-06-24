import 'package:ceb_app/reusable_widgets/app_bar.dart';
import 'package:ceb_app/screens/bill_payment.dart';
import 'package:ceb_app/screens/customer_service_screen.dart';
import 'package:ceb_app/screens/meter_reading_capture_screen.dart';
import 'package:ceb_app/screens/past_bill_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ceb_app/utils/color_utils.dart';

class HomeScreen extends StatefulWidget {
  final String accountNumber;

  const HomeScreen({Key? key, required this.accountNumber}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  void fetchUserName() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.accountNumber)
          .get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'];
        });
      }
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        title: 'Ceylon Electricity Board ',
        actions: <Widget>[],
        color: Color(0xFFFFD400),
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
                  'Welcome, $userName',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
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
                          builder: (context) => MeterReadingCapture(
                              accountNumber: widget.accountNumber)),
                    );
                  },
                  child: ListTile(
                    title: Center(child: Text('Get meter reading')),
                    subtitle: Center(
                        child:
                            Text('Click here to capture your meter reading')),
                  ),
                ),
                SizedBox(height: 35),
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
                          builder: (context) => PastBillDetails(
                              accountNumber: widget.accountNumber)),
                    );
                  },
                  child: ListTile(
                    title: Center(child: Text('Past Bill details')),
                    subtitle: Center(
                        child:
                            Text('Click here to view your past bill details')),
                  ),
                ),
                SizedBox(height: 35),
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
                          builder: (context) => BillPaymentScreen(
                              accountNumber: widget.accountNumber)),
                    );
                  },
                  child: ListTile(
                    title: Center(child: Text('Bill payments')),
                    subtitle:
                        Center(child: Text('Click here to pay your bill')),
                  ),
                ),
                SizedBox(height: 35),
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
                          builder: (context) => CustomerService(
                              accountNumber: widget.accountNumber)),
                    );
                  },
                  child: ListTile(
                    title: Center(child: Text('Other service')),
                    subtitle: Center(
                        child: Text('Click here to know about our services')),
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
