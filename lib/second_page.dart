import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:late_provider_issue/main.dart';
import 'package:late_provider_issue/providers.dart';

class SecondPage extends HookConsumerWidget {
  const SecondPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (_, ref, __) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ref.read(counterProvider.notifier).increment();
                      },
                      child: Text('Counter: ${ref.watch(counterProvider)}'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(counter2Provider.notifier).increment();
                      },
                      child: Text('Counter2: ${ref.watch(counter2Provider)}'),
                    ),
                  ],
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(prefsProvider).setInt('count', ref.read(counterProvider));
                context.pop();
              },
              child: const Text('Prev page'),
            ),
          ],
        ),
      ),
    );
  }
}
