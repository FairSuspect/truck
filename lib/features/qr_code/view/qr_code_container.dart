import 'package:flutter/widgets.dart';

class QrCodeContainer extends StatelessWidget {
  const QrCodeContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(36.0),
          ),
          gradient: LinearGradient(
            colors: [Color(0xFFD1E6FF), Color(0xFF3F8AE0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child: child,
    );
  }
}
