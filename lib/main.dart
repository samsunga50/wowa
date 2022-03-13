import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "ceb.dart";

double c = 0;

void main() {
  runApp(const MaterialApp(
    title: 'CEB Bill Calculator',
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(208, 6, 31, 120),
        title: const Center(
            child: Text(
          'CEB Bill Calculator',
          style: TextStyle(color: Color.fromARGB(255, 221, 115, 15)),
        )),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  MyCustomForm({Key? key}) : super(key: key);

  final ValueNotifier<double> _charge = ValueNotifier<double>(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter number of kWh used',
            ),
            onChanged: (text) {
              c = calculateCharge(text);
              c = double.parse(c.toStringAsFixed(2));
              print('Charge: $c');
              _charge.value = c;
            },
          ),
        ),
        ValueListenableBuilder<double>(
            builder: (BuildContext context, double value, Widget? child) {
              // This builder will only get called when the _counter
              // is updated.
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context)
                              .style
                              .apply(fontSizeFactor: 2.0),
                          children: <TextSpan>[
                        const TextSpan(text: 'Charge is '),
                        TextSpan(text: 'Rs $value'),
                      ])),
                  child!,
                ],
              );
            },
            valueListenable: _charge,
            // The child parameter is most helpful if the child is
            // expensive to build and does not depend on the value from
            // the notifier.
            child: const Text("only."))
      ],
    );
  }
}
