import 'package:flutter/widgets.dart';
import 'package:truck/features/sign_in/view/text_field.dart';
import 'oil_message_container.dart';

class OilStatusPage extends StatelessWidget {
  const OilStatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            OilMessageContainer(),
            SizedBox(height: 32),
            OutlinedTextField(label: "Mileage")
          ],
        ),
      ),
    );
  }
}
