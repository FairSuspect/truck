import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  void init() {
    dotenv.load();
  }
}
