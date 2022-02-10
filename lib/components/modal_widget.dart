import 'package:flutter/material.dart';
import 'package:giffty_flutter/utils/palette.dart';

class ModalWidget extends StatelessWidget {
  final Widget content;

  const ModalWidget({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 640,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Column(
          children: [
            Icon(
              Icons.remove_rounded,
              size: 56,
              color: Theme.of(context).colorScheme.primary,
            ),
            content,
          ],
        ),
      ),
      decoration: const BoxDecoration(
        color: PaletteColor.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
    );
  }
}
