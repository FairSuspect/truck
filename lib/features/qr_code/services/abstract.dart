import 'package:truck/features/qr_code/modes/qr.dart';

abstract class QrCodeService {
  Future<Qr> fetchData();
}
