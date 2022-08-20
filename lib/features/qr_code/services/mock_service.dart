import 'dart:math';

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/features/qr_code/modes/qr.dart';
import 'package:truck/features/qr_code/services/abstract.dart';

class QrMockService implements QrCodeService {
  static const _variants = [
    "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
  ];
  @override
  Future<Qr> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    final prefs = await SharedPreferences.getInstance();
    final vin = prefs.getString('vin');
    Logger('QR Generator').log(Level.INFO, "Vin: $vin");
    return Qr(
        data: _variants[Random().nextInt(_variants.length)],
        due: DateTime.now().add(Duration(minutes: 10 + Random().nextInt(10))));
  }
}
