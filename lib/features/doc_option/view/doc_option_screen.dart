import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:truck/features/doc_option/provider/provider.dart';
import 'package:truck/features/doc_option/view/doc_option_tile.dart';

class DocOptionScreen extends StatelessWidget {
  const DocOptionScreen({Key? key}) : super(key: key);
  static const String routeName = '/doc_option';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed:
              Provider.of<DocOptionProvider>(context, listen: false).onPop,
          icon: SvgPicture.asset("assets/icons/chevron_left_small.svg"),
        ),
        title: const Text("Doc option"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: ((context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: DocOptionTile(title: "Option #$index", onTap: () {}),
                ))),
      ),
    );
  }
}
