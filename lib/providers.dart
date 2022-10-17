import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'first_page.dart';

/// prefsProvider initally throws UnimplementedError which would be overriden in the [FirstPage] with the SharedPreferences instance
/// 
final prefsProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError());

/// [counterProvider], which manages the [CounterNotifier]
final counterProvider = StateNotifierProvider.autoDispose<CounterNotifier, int>(
  (ref) {
    /// watches for the [prefsProvider] but still its not aware of the [prefsProvider] if it overrides
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
}
