import 'package:flutter/material.dart';
import 'dart:math';

class Tips extends StatefulWidget {
  const Tips({super.key});

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  final List<String> tips = [
    "Tip 1: Turn off lights when not in use.",
    "Tip 2: Use energy-efficient light bulbs.",
    "Tip 3: Unplug devices when not in use.",
    "Tip 4: Use a programmable thermostat.",
    "Tip 5: Wash clothes in cold water.",
    "Tip 6: Use ceiling fans to stay cool.",
    "Tip 7: Seal windows and doors to prevent air leaks.",
    "Tip 8: Use power strips to reduce standby power consumption.",
    "Tip 9: Maintain your HVAC system regularly.",
    "Tip 10: Use natural light whenever possible.",
    "Tip 11: Install solar panels.",
    "Tip 12: Use a clothesline instead of a dryer.",
    "Tip 13: Insulate your home properly.",
    "Tip 14: Use energy-efficient appliances.",
    "Tip 15: Cook with a microwave or toaster oven.",
    "Tip 16: Take shorter showers.",
    "Tip 17: Use a laptop instead of a desktop computer.",
    "Tip 18: Turn off your computer when not in use.",
    "Tip 19: Install low-flow showerheads.",
    "Tip 20: Use smart power strips."
  ];

  final Random random = Random();
  late List<String> selectedTips;

  @override
  void initState() {
    super.initState();
    selectedTips = _getRandomTips();
  }

  List<String> _getRandomTips() {
    List<String> tempList = List.from(tips);
    tempList.shuffle(random);
    return tempList.take(5).toList();
  }

  void _showTipDetail(String tip) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tip Detail"),
          content: Text(tip),
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
          color: Color(0xFF720F11),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "Tips to Reduce Your Electricity Usage",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 400,
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: selectedTips
                            .map(
                              (tip) => GestureDetector(
                                onTap: () => _showTipDetail(tip),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    tip,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                  onPressed: () {
                    // Your logic here
                  },
                  child: ListTile(
                    title: Center(child: Text('Continue to Payment')),
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
