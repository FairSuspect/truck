import 'package:truck/features/sign_in/view/view.dart';
import 'package:truck/services/navigation.dart';

class MainProvider {
  void logOut() {
    Navigation()
        .key
        .currentState!
        .popUntil((route) => !Navigation().key.currentState!.canPop());
    Navigation().key.currentState!.pushReplacementNamed(SignInScreen.routeName);
  }
}
