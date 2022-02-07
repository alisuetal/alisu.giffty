import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giffty_flutter/components/button_widget.dart';
import 'package:giffty_flutter/components/header_widget.dart';
import 'package:giffty_flutter/utils/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _nextPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.EVENT_DETAILS);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const HeaderWidget(goBack: false),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    "Need an app to help you host a Secret Santa?",
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Enter the names, gift suggestions, and more for free!",
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              "assets/imgs/illustrations/giftIllustration.svg",
              height: 200,
              fit: BoxFit.fitWidth,
            ),
            ButtonWidget(
              text: "Start",
              assetIcon: "assets/imgs/icons/nextIcon.svg",
              function: () => _nextPage(context),
              enabled: true,
            )
          ],
        ),
      ),
    );
  }
}
