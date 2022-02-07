import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderWidget extends StatelessWidget {
  final bool goBack;
  const HeaderWidget({Key? key, required this.goBack}) : super(key: key);

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
            child: RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                "assets/imgs/icons/nextIcon.svg",
                height: 24,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/imgs/logo.svg",
              height: 28,
              fit: BoxFit.scaleDown,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Giffty",
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
        SvgPicture.asset(
          "assets/imgs/icons/settingsIcon.svg",
          height: 36,
          fit: BoxFit.scaleDown,
        ),
      ],
    );
  }
}
