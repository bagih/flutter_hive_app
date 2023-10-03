import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // init flutter
  await Hive.initFlutter();

  // open a box
  await Hive.openBox('bagihbox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _textEditingController = TextEditingController();
  String? _boxResult = '';

  final _box = Hive.box('bagihbox');

  void writeBox() {
    if (_textEditingController.text.isNotEmpty) {
      _box.put(1, _textEditingController.text);
    }
  }

  void readBox() {
    setState(() {
      _boxResult = _box.get(1);
    });
  }

  void deleteBoxEntry() {
    _box.delete(1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text Result
              Text(
                _boxResult ?? 'no data found',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'type anything'),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // Button write
              bodyButton(onPressed: writeBox, textValue: 'Write'),

              // Button read
              bodyButton(onPressed: readBox, textValue: 'Read'),

              // Button Delete
              bodyButton(onPressed: deleteBoxEntry, textValue: 'Delete'),
            ],
          ),
        ),
      ),
    );
  }

  MaterialButton bodyButton(
      {void Function()? onPressed, required String textValue}) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.amber[200],
      child: Text(textValue),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
