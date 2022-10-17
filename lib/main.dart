import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'first_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      child: MyApp(sharedPrefs: sharedPrefs),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.sharedPrefs,
  });

  final SharedPreferences sharedPrefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(
        sharedPrefs: sharedPrefs,
      ),
    );
  }
}

/// utils
///
extension NavExtension on BuildContext {
  void push(Widget child) {
    Navigator.of(this).push(MaterialPageRoute(builder: (_) => child));
  }

  void pop() {
    Navigator.of(this).pop();
  }
}
