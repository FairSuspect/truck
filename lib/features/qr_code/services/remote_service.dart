import 'package:flutter_dotenv/flutter_dotenv.dart';
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

    late final String vin;
    try {
      final vinResponse = await dio.get('/driver/get_current_truck');
      vin = User.fromJson(vinResponse.data).vin;
    } catch (e) {
      final prefs = await SharedPreferences.getInstance();
      Logger('QR Generator').log(Level.WARNING,
          "Failed to fetch vin from remote server. Using local vin");

      vin = prefs.getString('vin')!;
    }
    Logger('QR Generator').log(Level.INFO, "Vin: $vin");

    return Qr(
        data: '${dotenv.env['DOMAIN']}/dashboard/truck/$vin',
        due: DateTime.now().add(const Duration(minutes: 16)));
  }
}
