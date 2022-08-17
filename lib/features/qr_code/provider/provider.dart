import 'package:flutter/widgets.dart';
import 'package:truck/features/qr_code/modes/qr.dart';
import 'package:truck/features/qr_code/services/abstract.dart';

class QrCodeProvider extends ChangeNotifier {
  Qr qr = Qr(
      data: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
      due: DateTime.now().add(const Duration(minutes: 15)));

  final QrCodeService service;
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  QrCodeProvider(this.service) {
    getCode();
  }

  Future<void> getCode() async {
    isLoading = true;
    try {
      qr = await service.fetchData();
    } finally {
      isLoading = false;
    }
    isLoading = false;
    notifyListeners();
  }

  int get minutesRemaining => qr.due.difference(DateTime.now()).inMinutes;
}
