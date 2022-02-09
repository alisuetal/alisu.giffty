import 'package:flutter/material.dart';

class AddItemWidget extends StatelessWidget {
  final String text;
  final void Function() function;

  const AddItemWidget({
    Key? key,
    required this.text,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: GestureDetector(
        onTap: function,
        child: Container(
          height: 64,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.08)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Colors.white.withOpacity(0.4)),
                ),
                Icon(
                  Icons.add_rounded,
                  size: 40,
                  color: Colors.white.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
