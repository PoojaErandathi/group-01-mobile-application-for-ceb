import 'package:ceb_app/reusable_widgets/app_bar.dart';
import 'package:ceb_app/screens/customer_service_screen.dart';
import 'package:ceb_app/screens/past_bill_details.dart';
import 'package:ceb_app/screens/add_account_number_screen.dart';
import 'package:flutter/material.dart';
import 'package:ceb_app/screens/signin_screen.dart';
import 'package:ceb_app/utils/color_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                          builder: (context) =>
                              const EnterYourAccountNuumber()),
                    );
                  },
                  child: ListTile(
                    title: Center(child: Text('Get meeter reading')),
                    subtitle: Center(
                        child:
                            Text('Click here to capture your meteer reading')),
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
                          builder: (context) => const PastBillDetails()),
                    );
                  },
                  child: ListTile(
                    title: Center(child: Text('Past Bill details')),
                    subtitle: Center(
                        child:
                            Text('Click here to view your past bill details')),
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
                    // Navigator.push(
                    // context,
                    // MaterialPageRoute(
                    //   builder: (context) =>
                    //     const CustomerService()),
                    // );
                  },
                  child: ListTile(
                    title: Center(child: Text('Bill payments')),
                    subtitle:
                        Center(child: Text('Click here to pay your bill')),
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
                          builder: (context) => const CustomerService()),
                    );
                  },
                  child: ListTile(
                    title: Center(child: Text('Other service')),
                    subtitle: Center(
                        child: Text('Click here to know about our services')),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
