import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BillPaymentScreen extends StatefulWidget {
  final String accountNumber;

  const BillPaymentScreen({required this.accountNumber, Key? key}) : super(key: key);

  @override
  _BillPaymentScreenState createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _userFuture;
  final TextEditingController _amountController = TextEditingController();
  bool _isPaying = false; // To track the payment state

  @override
  void initState() {
    super.initState();
    _userFuture = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.accountNumber)
        .get();
  }

  void _payNow() async {
    final double? amount = double.tryParse(_amountController.text.trim());

    if (amount == null || amount <= 0) {
      _showAlertDialog(
        "Error",
        "Please enter a valid amount.",
        Icons.error_outline,
        Colors.red,
      );
      return;
    }

    setState(() {
      _isPaying = true;
    });

    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isPaying = false;
    });

    _showAlertDialog(
      "Success",
      "Payment submitted successfully!",
      Icons.check_circle_outline,
      Colors.green,
    );

    _amountController.clear(); // Clear the text field
  }

  void _showAlertDialog(
      String title, String message, IconData icon, Color iconColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(icon, color: iconColor),
              SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('User data not found'));
          }

          final userData = snapshot.data!.data()!;
          final name = userData['name'] ?? 'N/A';
          final accountStatus = userData['accountStatus'] ?? 'N/A';
          final penalty = userData['penalty'] ?? 'N/A';
          final credit = userData['credit'] ?? 'N/A';
          final totalPayable = userData['totalPayable'] ?? 'N/A';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Account No:', widget.accountNumber),
                  _buildLabel('Name:', name),
                  _buildLabel('Account Status:', accountStatus),
                  _buildLabel('Penalty:', penalty.toString()),
                  _buildLabel('Credit Balance:', credit.toString()),
                  _buildLabel('Total Payable:', totalPayable.toString()),
                  Divider(color: Colors.white),
                  TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                    onPressed: _isPaying ? null : _payNow,
                    child: _isPaying
                        ? CircularProgressIndicator(color: Colors.black)
                        : Center(child: Text('Pay Now')),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: Color(0xFF720F11),
    );
  }

  Widget _buildLabel(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$title ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
