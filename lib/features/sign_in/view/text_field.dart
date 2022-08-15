import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OutlinedTextField extends StatefulWidget {
  const OutlinedTextField({Key? key, this.onSaved, required this.label})
      : super(key: key);
  final ValueChanged<String?>? onSaved;
  final String label;
  @override
  State<OutlinedTextField> createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {
  late final TextEditingController _controller;
  bool hasFocus = false;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void onFocusChanged(bool gained) {
    setState(() {
      hasFocus = gained;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FocusScope(
      onFocusChange: onFocusChanged,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 8, 16, 8),
        decoration: BoxDecoration(
            border: Border.all(
                color: hasFocus
                    ? theme.inputDecorationTheme.focusColor!
                    : Colors.transparent),
            color: theme.inputDecorationTheme.fillColor,
            borderRadius: const BorderRadius.all(Radius.circular(14.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                onSaved: widget.onSaved,
                decoration: InputDecoration(
                  label: Text(widget.label),
                ),
              ),
            ),
            Flexible(
              child: IconButton(
                onPressed: _controller.clear,
                icon: SvgPicture.asset('assets/icons/cancel.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
