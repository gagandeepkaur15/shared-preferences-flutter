import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Future inst() async =>
      _MyAppState._pref = await SharedPreferences.getInstance();
  inst();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _cont = TextEditingController();
  String? _data;

  static SharedPreferences? _pref;
  static const String _key = 'data';

  Future setData(String data) async => await _pref?.setString(_key, data);

  String? getData() => _pref?.getString(_key);

  @override
  void initState() {
    super.initState();
    _data = getData() ?? 'No Data';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.brown[100],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _data == null ? const Text('No Data') : Text(_data!),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _cont,
                decoration: InputDecoration(
                  hintText: 'Enter Text',
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: (() async {
                  await setData(_cont.text);
                  setState(() {
                    _data = getData();
                  });
                }),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.brown,
                  ),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
