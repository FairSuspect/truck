import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("Contact Us",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SelectableText('founders@docksys.co', style: TextStyle(fontSize: 20)),
          Text("Corporate Address:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SelectableText('335010 Georgia Tech Station',
              style: TextStyle(fontSize: 20)),
          SelectableText('351 Ferst Drive', style: TextStyle(fontSize: 20)),
          SelectableText('Atlanta, GA 30332', style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}
