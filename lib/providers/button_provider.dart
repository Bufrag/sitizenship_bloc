import 'package:flutter_riverpod/flutter_riverpod.dart';

final isEuropeProvider = StateProvider<bool>(
  (ref) => false,
);
final isPopularProvider = StateProvider<bool>(
  (ref) => true,
);

final isFastPassportProvider = StateProvider<bool>((ref) => false);
