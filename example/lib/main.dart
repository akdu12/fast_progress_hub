import 'package:fast_progress_hub/fast_progress_hub.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FastProgressHub(
      loading: false,
      dismissible: true,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ReduxExample(),
      ),
    );
  }
}

class ProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create the store with our Reducer and Middleware
    bool dummyRedux(bool state, action) {
      return !state;
    }

    final store = new Store<bool>(
      dummyRedux,
      initialState: false,
      middleware: [],
    );
    store.onChange.listen((event) {});
  }
}

class ReduxExample extends StatefulWidget {
  @override
  State createState() {
    return _ReduxExampleState();
  }
}

class _ReduxExampleState extends State<ReduxExample> {
  // Create the store with our Reducer and Middleware
  bool dummyRedux(bool state, action) {
    return !state;
  }

  Store store;

  @override
  void initState() {
    store = Store<bool>(
      dummyRedux,
      initialState: false,
      middleware: [],
    );
    store.onChange.listen((state) {
      FastProgressHub.of(context).loading = state;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            store.dispatch("Toggle");
          }),
    );
  }
}
