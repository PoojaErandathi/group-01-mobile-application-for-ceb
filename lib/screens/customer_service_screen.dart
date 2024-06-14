import 'package:ceb_app/reusable_widgets/app_bar.dart';
import 'package:ceb_app/screens/submit_complain_screen.dart';
import 'package:ceb_app/screens/tips_screen.dart';
import 'package:ceb_app/utils/color_utils.dart';
import 'package:flutter/material.dart';

class CustomerService extends StatefulWidget {
  const CustomerService({super.key});

  @override
  State<CustomerService> createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
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
              120, // Adjusted the top padding to move the logo up
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the value for the desired roundedness
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Complains()),
                    );
                  },
                  child: ListTile(
                    title: Center(child: Text('Submit your complains')),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the value for the desired roundedness
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Complains()),
                    );
                  },
                  child: ListTile(
                    title: Center(
                        child:
                            Text('Submit a request to get a new connection')),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the value for the desired roundedness
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Tips()),
                    );
                  },
                  child: ListTile(
                    title: Center(
                        child: Text('Tips for reduce your electricity usage')),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
