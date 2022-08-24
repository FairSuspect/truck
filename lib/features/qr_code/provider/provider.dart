import 'package:flutter/widgets.dart';
import 'package:truck/features/qr_code/modes/qr.dart';
import 'package:truck/features/qr_code/services/abstract.dart';

class QrCodeProvider extends ChangeNotifier {
  Qr? qr;

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

  int get minutesRemaining =>
      qr?.due.difference(DateTime.now()).inMinutes ?? 15;
}
