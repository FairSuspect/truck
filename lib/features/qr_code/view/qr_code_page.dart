import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck/features/qr_code/qr_code.dart';
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
              children: [
                const QrCodeBody(),
                const SizedBox(height: 82),
                Consumer<QrCodeProvider>(builder: (context, controller, child) {
                  return MessageContainer(
                      message: controller.isLoading
                          ? "..."
                          : "Expires in ${controller.minutesRemaining} min");
                })
              ],
            ),
          )),
          const Spacer(),
          SecondaryButton(
              onPressed: Provider.of<QrCodeProvider>(context).getCode,
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
