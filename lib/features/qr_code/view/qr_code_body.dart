import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:truck/features/qr_code/qr_code.dart';

class QrCodeBody extends StatelessWidget {
  const QrCodeBody({Key? key}) : super(key: key);

  static const qrWidth = 274.0;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(30.0),
            )),
        padding: const EdgeInsets.all(13.0),
        child: Consumer<QrCodeProvider>(builder: (context, controller, child) {
          return controller.isLoading
              ? Container(
                  width: qrWidth,
                  height: qrWidth,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )
              : controller.qr == null
                  ? const _QrCodeErrorWidget(qrWidth: qrWidth)
                  : QrImage(
                      data: controller.qr!.data,
                      size: qrWidth,
                    );
        }));
  }
}

class _QrCodeErrorWidget extends StatelessWidget {
  const _QrCodeErrorWidget({
    Key? key,
    required this.qrWidth,
  }) : super(key: key);

  final double qrWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: qrWidth,
        height: qrWidth,
        child: const Center(
          child: Text("Failed to generate QR Code. Please, try again"),
        ));
  }
}
