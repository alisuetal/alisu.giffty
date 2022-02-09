import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderWidget extends StatelessWidget {
  final bool goBack;
  final void Function(BuildContext) headerFunction;
  const HeaderWidget(
      {Key? key, required this.goBack, required this.headerFunction})
      : super(key: key);

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (goBack)
          GestureDetector(
            onTap: () => _goBack(context),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: 36,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/imgs/logo.svg",
              height: 36,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Giffty",
              style: TextStyle(
                fontFamily: "Coolvetica",
                fontSize: 36,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => headerFunction(context),
          child: SvgPicture.asset(
            "assets/imgs/icons/settingsIcon.svg",
            height: 36,
            fit: BoxFit.scaleDown,
          ),
        ),
      ],
    );
  }
}
