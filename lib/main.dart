import 'package:flutter/material.dart';
import 'package:flutter_test_zeroconf/bonsoir-sd.dart';
import 'package:flutter_test_zeroconf/mDNS.dart';

void main() {
  runApp(const MaterialApp(
    home: MyWidget(),
  ));
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);
  void handleClick(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('This is a Snackbar'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Print mDNS Connection !!!!!!!!"),
      ),
      body: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () async {
              // handleClick(context);
              await mDNS();
              // await bonsoirSd();
            },
            child: const Text("Click Me!!!"),
          ),
        ),
      ),
    );
  }
}
