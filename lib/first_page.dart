import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:late_provider_issue/main.dart';
import 'package:late_provider_issue/providers.dart';
import 'package:late_provider_issue/second_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends HookConsumerWidget {
  const FirstPage({
    super.key,
    required this.sharedPrefs,
  });

  final SharedPreferences sharedPrefs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push(
              /// here we override our prefsProvider with the sharedPreferences instance
              ProviderScope(
                overrides: [
                  prefsProvider.overrideWithValue(sharedPrefs),
                ],
                child: const SecondPage(),
              ),
            );
          },
          child: const Text('Next page'),
        ),
      ),
    );
  }
}
