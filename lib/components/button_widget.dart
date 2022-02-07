import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final String assetIcon;
  final Function() function;
  final bool enabled;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.assetIcon,
    required this.function,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 64,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.headline4,
              ),
              SvgPicture.asset(
                assetIcon,
                height: 28,
                fit: BoxFit.scaleDown,
                color: Colors.black,
              ),
            ],
          ),
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}
