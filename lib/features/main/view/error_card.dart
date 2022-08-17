import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:truck/features/main/provider/option_provider.dart';
import 'package:truck/features/shared/view/buttons/secondary_button.dart';
import 'package:truck/features/sign_in/view/custom_card.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Column(
      children: [
        const Text("Something went wrong"),
        const SizedBox(
          height: 16,
        ),
        SecondaryButton(
            onPressed: Provider.of<OptionProvider>(context).fetchOptions,
            child: const Text("Try again"))
      ],
    ));
  }
}
