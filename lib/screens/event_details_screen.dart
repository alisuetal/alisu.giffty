import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giffty_flutter/components/button_widget.dart';
import 'package:giffty_flutter/components/header_widget.dart';
import 'package:giffty_flutter/components/screen_holder_widget.dart';
import 'package:giffty_flutter/components/steps_widget.dart';
import 'package:giffty_flutter/components/text_field_currency_widget.dart';
import 'package:giffty_flutter/models/event.dart';
import 'package:giffty_flutter/utils/app_routes.dart';
import 'package:giffty_flutter/utils/tools.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  final double initialPrice;
  final void Function(BuildContext) headerFunction;
  const EventDetailsScreen(
      {Key? key, required this.initialPrice, required this.headerFunction})
      : super(key: key);

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  String price = "0.00";

  @override
  void initState() {
    if (widget.initialPrice != 0) {
      price = widget.initialPrice.toString();
    }
    super.initState();
  }

  void _nextScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.GUESTS);
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context, listen: false);
    return ScreenHolderWidget(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              HeaderWidget(
                goBack: true,
                headerFunction: widget.headerFunction,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: StepsWidget(step: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "Let’s set the budget first.",
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
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
                anchor: (String price) {
                  setState(() {
                    this.price = price;
                  });
                },
                hint: "Price (optional)",
                text: widget.initialPrice > 0
                    ? Tools().formatPrice(widget.initialPrice)
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                text: (price.isNotEmpty && Tools().deformatPrice(price) > 0)
                    ? "Next"
                    : "Skip",
                materialIcon: Icons.arrow_forward_rounded,
                function: () {
                  _nextScreen(context);
                  if (price.isNotEmpty) {
                    event.setPrice(Tools().deformatPrice(price));
                  }
                },
                enabled: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
