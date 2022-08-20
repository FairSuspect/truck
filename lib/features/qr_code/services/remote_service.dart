import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/features/main/models/user.dart';
import 'package:truck/features/qr_code/modes/qr.dart';
import 'package:truck/features/qr_code/services/abstract.dart';
import 'package:truck/services/remote/api.dart';

class RemoteQrService implements QrCodeService {
  @override
  Future<Qr> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));

    final dio = Api().dio;

    final vinResponse = await dio.get('/driver/get_current_truck');
    late final String vin;
    try {
      vin = User.fromJson(vinResponse.data).vin;
    } catch (e) {
      final prefs = await SharedPreferences.getInstance();
      vin = prefs.getString('vin')!;
    }
    Logger('QR Generator').log(Level.INFO, "Vin: $vin");

    return Qr(
        data: '${dio.options.baseUrl}/driver/get_truck_archive_by_qr/?vin=$vin',
        due: DateTime.now().add(const Duration(minutes: 15)));
  }
}
