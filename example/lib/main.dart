import 'package:fast_progress_hub/fast_progress_hub.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

void main() {
  runApp(CustomIndicatorExample());
}

class CustomIndicatorExample extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FastProgressHub(
      progressIndicator: SizedBox(
        width: 50,
        height: 50,
        child: LoadingIndicator(
            indicatorType: Indicator.squareSpin, color: Colors.lightBlue),
      ),
      loading: false,
      dismissible: true,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.lightBlue)),
            onPressed: () {
              FastProgressHub.of(context)!.startLoading();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "make async call",
                style: TextStyle(color: Colors.white),
              ),
            )),
      ),
    );
  }
}
