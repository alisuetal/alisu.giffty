import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giffty_flutter/components/button_widget.dart';
import 'package:giffty_flutter/components/header_widget.dart';
import 'package:giffty_flutter/components/text_field.dart';
import 'package:giffty_flutter/utils/app_routes.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({Key? key}) : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  String price = "";

  void _nextPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.EVENT_DETAILS);
  }

  void _getPrice(String price) {
    setState(() {
      this.price = price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const HeaderWidget(goBack: true),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Let’s set the budget first.",
                            style: Theme.of(context).textTheme.headline1,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  "assets/imgs/illustrations/moneyIllustration.svg",
                  height: 128,
                  fit: BoxFit.fitWidth,
                  // color: Colors.white60,
                ),
                Column(
                  children: [
                    TextFieldWidget(
                      type: 1,
                      anchor: (String price) => _getPrice(price),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                      text: price.isNotEmpty ? "Start" : "Skip",
                      assetIcon: "assets/imgs/icons/nextIcon.svg",
                      function: () => _nextPage(context),
                      enabled: price.isNotEmpty,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
