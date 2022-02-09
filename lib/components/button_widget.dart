import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final IconData materialIcon;
  final void Function() function;
  final bool enabled;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.materialIcon,
    required this.function,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? function : () {},
      child: Container(
        height: 64,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: enabled
                    ? Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)
                    : Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white.withOpacity(0.4)),
              ),
              Icon(
                materialIcon,
                size: 36,
                color: enabled ? Colors.white : Colors.white.withOpacity(0.4),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: enabled
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primary.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
