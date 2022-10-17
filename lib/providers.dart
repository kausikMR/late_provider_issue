import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'first_page.dart';

/// prefsProvider initally throws UnimplementedError which would be overriden in the [FirstPage] with the SharedPreferences instance.
final prefsProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError());

/// [counterProvider], which manages the [CounterNotifier]
final counterProvider = StateNotifierProvider<CounterNotifier, int>(
  (ref) {
    /// watches for the [prefsProvider] but still its not aware of the [prefsProvider] if it overrides.
    final prefs = ref.watch(prefsProvider);
    final prevCount = prefs.getInt('count');
    final counterNotifier = CounterNotifier(prevCount);
    return counterNotifier;
  },
  dependencies: [
    /// Adding [prefsProvider] in dependencies makes it aware of the overrides made on the [prefsProvider].
    prefsProvider,
  ],
);

/// [counterNotifier] which manages the state of the count
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier([int? count]) : super(count ?? 0);
  void increment() => state++;
  void update(int count) => state = count;
}

/// Nested Provider Overriding Issue:
/// The providers which depends on other providers by read, watch or listen (ie. [counterProvider], in our case being listened by our [counter2Provider]),
/// [counter2Provider] doesn't get notified by any overriden changes on dependent provider,
/// [counter2Provider] watches using ref.watch() or listens using ref.listen() to the counterProvider.
final counter2Provider = StateNotifierProvider(
  (ref) {
    final counterNotifier = CounterNotifier(ref.read(counterProvider));
    ref.listen(counterProvider, (_, count) {
      counterNotifier.update(count);
    });
    return counterNotifier;
  },
  dependencies: [
    /// We can solve the NestedProviderOverriding issue by adding every provider we depend on by using ref.read(), ref.watch(), ref.listen() to our [dependencies].
    /// In this case we solve this by adding [counterProvider] as an dependency for [counter2Provider].
    counterProvider,
  ],
);
