import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giffty_flutter/components/button_widget.dart';
import 'package:giffty_flutter/components/header_widget.dart';
import 'package:giffty_flutter/utils/app_routes.dart';
import 'package:giffty_flutter/utils/palette.dart';

class HomeScreen extends StatelessWidget {
  final String giftIllustration =
      'assets/imgs/illustrations/giftIllustration.svg';
  final String nextIcon = 'assets/imgs/icons/nextIcon.svg';
  final void Function(BuildContext) headerFunction;

  const HomeScreen({Key? key, required this.headerFunction}) : super(key: key);

  void _nextScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.EVENT_DETAILS);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.secondary,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 640,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HeaderWidget(goBack: false, headerFunction: headerFunction),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      giftIllustration,
                      height: 200,
                      fit: BoxFit.fitWidth,
                      semanticsLabel: 'A 3D gift illustration',
                    ),
                  ],
                ),
                ButtonWidget(
                  text: "Start",
                  materialIcon: Icons.arrow_forward_rounded,
                  function: () => _nextScreen(context),
                  enabled: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
