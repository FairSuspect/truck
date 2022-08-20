import 'package:flutter/widgets.dart';
import 'package:truck/features/oil_status/service/oil_service.dart';

class OilStatusProvider {
  final OilService service;

  OilStatusProvider(this.service);

  final mileageTextController = TextEditingController();
  Future<void> onSubmitted() async {
    final int? mileage = int.tryParse(mileageTextController.text);
    if (mileage == null) return;

    try {
      await sendMileage(mileage);
    } finally {
      mileageTextController.clear();
    }
  }

  Future<void> sendMileage(int value) async {
    await service.sendMileage(value);
  }
}
