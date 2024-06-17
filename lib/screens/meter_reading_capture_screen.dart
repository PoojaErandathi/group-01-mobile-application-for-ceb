import 'dart:io';
import 'package:ceb_app/screens/bill_detail_screen.dart'; // Import the BillDetailScreen
import 'package:ceb_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MeterReadingCapture extends StatefulWidget {
  const MeterReadingCapture({Key? key}) : super(key: key);

  @override
  State<MeterReadingCapture> createState() => _MeterReadingCaptureState();
}

class _MeterReadingCaptureState extends State<MeterReadingCapture> {
  File? _image;

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> getImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      _showProgressDialog(context);
    }
  }

  void _showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Analysing..."),
            ],
          ),
        );
      },
    );

    // Future.delayed(Duration(seconds: 3), () {
    //   Navigator.of(context).pop(); // Dismiss the progress dialog
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => BillDetail(), // Navigate to BillDetailScreen
    //     ),
    //   );
    // });
  }

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
              120,
              20,
              0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _image == null
                    ? Text(
                        "No image selected",
                        style: TextStyle(color: Colors.white),
                      )
                    : Image.file(_image!),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFD400),
        onPressed: getImage,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
