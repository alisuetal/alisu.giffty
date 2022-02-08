import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giffty_flutter/components/button_widget.dart';
import 'package:giffty_flutter/components/header_widget.dart';
import 'package:giffty_flutter/components/text_field.dart';
import 'package:giffty_flutter/models/event.dart';
import 'package:giffty_flutter/utils/app_routes.dart';
import 'package:giffty_flutter/utils/tools.dart';
import 'package:provider/provider.dart';

class EventDetailsPage extends StatefulWidget {
  final int? initialPrice;
  const EventDetailsPage({Key? key, this.initialPrice}) : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  String price = "0.00";

  @override
  void initState() {
    if (widget.initialPrice != null && widget.initialPrice != 0) {
      price = widget.initialPrice.toString();
    }
    super.initState();
  }

  void _nextPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.EVENT_DETAILS);
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context, listen: false);
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
                      type: 1,
                      anchor: (String price) {
                        setState(() {
                          this.price = price;
                        });
                      },
                      text: widget.initialPrice != null
                          ? Tools().formatPrice(widget.initialPrice!)
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                      text:
                          (price.isNotEmpty && price != "0" && price != "0.00")
                              ? "Next"
                              : "Skip",
                      assetIcon: "assets/imgs/icons/nextIcon.svg",
                      function: () {
                        _nextPage(context);
                        event.setPrice(int.parse(
                            price.replaceAll('.', '').replaceAll(",", '')));
                      },
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
