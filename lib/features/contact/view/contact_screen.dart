import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SelectableText('founders@docksys.co'),
          Text("Contact Us"),
          Text("Corporate headquarters:"),
          SelectableText(
              '11 Merry Lane NP0000000000 New Jersey, East Hanover, 00000')
        ],
      ),
    );
  }
}
