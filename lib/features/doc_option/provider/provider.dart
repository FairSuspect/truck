import 'package:truck/services/navigation.dart';

class DocOptionProvider {
  void onPop() {
    Navigation().key.currentState!.pop();
  }
}
