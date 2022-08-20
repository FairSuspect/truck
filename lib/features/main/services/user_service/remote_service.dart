import 'package:truck/features/main/dto_models/user_dto.dart';
import 'package:truck/features/main/models/user.dart';
import 'package:truck/features/main/services/user_service/user_service.dart';
import 'package:truck/services/remote/api.dart';

class RemoteUserService implements UserService {
  @override
  Future<User> getUser() async {
    final response = await Api().dio.get('/driver/get_current_truck');
    final dto = UserDto.fromJson(response.data);

    return User(
        email: dto.vin, username: dto.driverPassword, role: dto.driverName);
  }
}
