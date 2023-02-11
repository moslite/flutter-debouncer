import 'package:debouncer/src/shared/utils/debouncer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final debouncer = Debouncer(milliseconds: 500);
  var autoCompleteText = '';
  final autoCompleteController = TextEditingController();

  void processAutoComplete(String text) {
    setState(() {
      autoCompleteText = text;
    });
  }

  @override
  void initState() {
    autoCompleteController.addListener(() {
      debouncer(() => processAutoComplete(autoCompleteController.text));
    });
    super.initState();
  }

  @override
  void dispose() {
    autoCompleteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: autoCompleteController,
              //onChanged: (value) => debouncer(() => processAutoComplete(value)),
            ),
            Text(autoCompleteText),
          ],
        ),
      ),
    );
  }
}
