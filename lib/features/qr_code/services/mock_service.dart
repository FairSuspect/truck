import 'dart:math';

import 'package:truck/features/qr_code/modes/qr.dart';
import 'package:truck/features/qr_code/services/abstract.dart';

class QrMockService implements QrCodeService {
  static const _variants = [
    "Plain text",
    "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    "1234567890",
    "1"
  ];
  @override
  Future<Qr> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    return Qr(
        data: _variants[Random().nextInt(_variants.length)],
        due: DateTime.now().add(Duration(minutes: 10 + Random().nextInt(10))));
  }
}
