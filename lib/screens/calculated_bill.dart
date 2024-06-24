import 'dart:io';
import 'package:ceb_app/screens/home_screen.dart';
import 'package:ceb_app/utils/color_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalculatedBill extends StatefulWidget {
  final String accountNumber;
  final String meterValue;
  final File image;
  final String readingForMonth;

  CalculatedBill({
    required this.accountNumber,
    required this.meterValue,
    required this.image,
    required this.readingForMonth,
  });

  @override
  _CalculatedBillState createState() => _CalculatedBillState();
}

class _CalculatedBillState extends State<CalculatedBill> {
  int? _previousReading;
  int? _currentReading;
  double? _monthlyCharge;
  double _fixedCharge = 150.0;
  double? _totalMonthlyBill;
  int? _monthlyUnits;

  @override
  void initState() {
    super.initState();
    _fetchPreviousReading();
  }

  Future<void> _fetchPreviousReading() async {
    try {
      final collection = FirebaseFirestore.instance
          .collection('users')
          .doc(widget.accountNumber)
          .collection('meterReadings');

      final previousMonth = DateFormat('yyyyMM').format(
        DateTime(
          int.parse(widget.readingForMonth.split('-')[0]),
          int.parse(widget.readingForMonth.split('-')[1]) - 1,
        ),
      );

      final snapshot = await collection.doc(previousMonth).get();

      if (snapshot.exists) {
        final previousReading = snapshot['readingValue'];
        final currentReading = int.parse(widget.meterValue);
        final monthlyUnits = (currentReading - previousReading) as int;

        // Calculate the monthly charge based on the tariff rates
        double monthlyCharge = 0;
        if (monthlyUnits <= 30) {
          monthlyCharge = monthlyUnits * 8.0;
          _fixedCharge = 150.0;
        } else if (monthlyUnits <= 60) {
          monthlyCharge = monthlyUnits * 20.0;
          _fixedCharge = 300.0;
        } else {
          _fixedCharge = 0.0;
          int remainingUnits = monthlyUnits;
          if (remainingUnits > 60) {
            monthlyCharge += 60 * 25.0;
            remainingUnits -= 60;
          }
          if (remainingUnits > 0) {
            int units = remainingUnits <= 30 ? remainingUnits : 30;
            monthlyCharge += units * 40.0;
            _fixedCharge += 400.0;
            remainingUnits -= units;
          }
          if (remainingUnits > 0) {
            int units = remainingUnits <= 30 ? remainingUnits : 30;
            monthlyCharge += units * 50.0;
            _fixedCharge += 1000.0;
            remainingUnits -= units;
          }
          if (remainingUnits > 0) {
            int units = remainingUnits <= 60 ? remainingUnits : 60;
            monthlyCharge += units * 50.0;
            _fixedCharge += 1500.0;
            remainingUnits -= units;
          }
          if (remainingUnits > 0) {
            monthlyCharge += remainingUnits * 75.0;
            _fixedCharge += 2000.0;
          }
        }

        final totalMonthlyBill = monthlyCharge + _fixedCharge;

        setState(() {
          _previousReading = previousReading;
          _currentReading = currentReading;
          _monthlyUnits = monthlyUnits;
          _monthlyCharge = monthlyCharge;
          _totalMonthlyBill = totalMonthlyBill;
        });
      } else {
        setState(() {
          _previousReading = null;
        });
      }
    } catch (e) {
      print("Error fetching previous reading: $e");
    }
  }

  Future<void> _saveAndProceed() async {
    try {
      final collection = FirebaseFirestore.instance
          .collection('users')
          .doc(widget.accountNumber)
          .collection('meterReadings');

      final previousMonth = DateFormat('yyyyMM').format(
        DateTime(
          int.parse(widget.readingForMonth.split('-')[0]),
          int.parse(widget.readingForMonth.split('-')[1]) - 1,
        ),
      );

      await collection.doc(previousMonth).get().then((snapshot) async {
        DateTime readOn = snapshot['readOn'].toDate();
        DateTime dueDate = readOn.add(Duration(days: 60));

        // Update the document for the previous month
        await collection.doc(previousMonth).update({
          'units': _monthlyUnits,
          'monthlyBill': _monthlyCharge,
          'fixedCharge': _fixedCharge,
          'totalPayable': _totalMonthlyBill,
          'dueDate': Timestamp.fromDate(dueDate),
        });

        // Calculate the next month
        final nextMonthDate = DateTime(
          int.parse(widget.readingForMonth.split('-')[0]),
          int.parse(widget.readingForMonth.split('-')[1]),
        ).add(Duration(days: 30));

        final nextMonth = DateFormat('yyyyMM').format(nextMonthDate);

        // Create a new document for the next month
        await collection.doc(nextMonth).set({
          'dueDate': Timestamp.fromDate(DateTime.now().add(Duration(days: 60))),
          'fixedCharge': 0,
          'imagePath': widget.image.path,
          'monthlyBill': 0,
          'readOn': Timestamp.fromDate(DateTime.now()),
          'readingValue': int.parse(widget.meterValue),
          'totalPayable': 0,
          'units': 0,
        });

        // Fetch the current value of totalPayable from the user's document
        final userDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(widget.accountNumber);
        final userSnapshot = await userDoc.get();
        final currentTotalPayable = userSnapshot['totalPayable'];

        // Update the totalPayable field with the new value
        final newTotalPayable = currentTotalPayable + _totalMonthlyBill!;
        await userDoc.update({
          'totalPayable': newTotalPayable,
        });

        // Show success message and navigate to PastBillDetails screen
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Success"),
              content: const Text(
                  "Bill for the previous month is successfully saved!"),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(accountNumber: widget.accountNumber)),
                    );
                  },
                ),
              ],
            );
          },
        );
      });
    } catch (e) {
      print("Error saving and proceeding: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFD400),
        elevation: 0,
        title: const Text(
          "Calculated Bill",
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
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Bill for ${widget.readingForMonth}",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 20),
                _monthlyCharge != null
                    ? Column(
                        children: [
                          Text(
                            "Monthly number of units: $_monthlyUnits",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Monthly charge: $_monthlyCharge.00",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Fixed charge: $_fixedCharge",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Total monthly bill: $_totalMonthlyBill.00",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: _saveAndProceed,
                            child: const Text(
                              'Save and proceed',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      )
                    : CircularProgressIndicator(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
