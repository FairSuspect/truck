import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:truck/features/qr_code/view/message_container.dart';
import 'package:truck/features/qr_code/view/qr_code_body.dart';
import 'package:truck/features/qr_code/view/qr_code_container.dart';
import 'package:truck/features/shared/view/buttons/secondary_button.dart';

class QrCodePage extends StatelessWidget {
  const QrCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
      child: Column(
        children: [
          QrCodeContainer(
              child: Padding(
            padding: const EdgeInsets.all(34.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                QrCodeBody(),
                SizedBox(height: 82),
                MessageContainer(message: "Expires in 15 min")
              ],
            ),
          )),
          const Spacer(),
          SecondaryButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.refresh),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Generate new code"),
                ],
              ))
        ],
      ),
    );
  }
}
