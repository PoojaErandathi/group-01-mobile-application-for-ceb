import 'package:ceb_app/reusable_widgets/reusable_widgets.dart';
import 'package:ceb_app/screens/meter_reading_capture_screen.dart';
import 'package:ceb_app/utils/color_utils.dart';
import 'package:flutter/material.dart';

class EnterYourAccountNuumber extends StatefulWidget {
  const EnterYourAccountNuumber({super.key});

  @override
  State<EnterYourAccountNuumber> createState() =>
      _EnterYourAccountNuumberState();
}

class _EnterYourAccountNuumberState extends State<EnterYourAccountNuumber> {
  TextEditingController _addAccountNumberConroller = TextEditingController();

  // Dummy account number
  final String dummyAccountNumber = "123456";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFD400),
        elevation: 0,
        title: const Text(
          "Ceylon Electricity Board",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            padding: EdgeInsets.fromLTRB(
              20,
              120, // Adjusted the top padding to move the logo up
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "Enter account number for get your meter reading easily",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                reusableTextField(
                  "Enter your account number",
                  Icons.numbers,
                  false,
                  _addAccountNumberConroller,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow, // Button color
                  ),
                  onPressed: () {
                    String enteredNumber = _addAccountNumberConroller.text;

                    if (enteredNumber == dummyAccountNumber) {
                      // Navigate to MeterReadingCapture
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MeterReadingCapture(),
                        ),
                      );
                    } else {
                      // Show alert dialog
                      _showAlertDialog(context);
                    }
                  },
                  child: ListTile(
                    title: Center(child: Text('Submit')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to show alert dialog
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Invalid Account Number"),
          content: Text("The account number you entered is incorrect."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
