import 'package:truck/features/oil_status/service/oil_service.dart';

class MockOilService implements OilService {
  @override
  Future<void> sendMileage(int value) async {}
}
