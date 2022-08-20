import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  Future<void> init() async {
    await dotenv.load();
  }
}
