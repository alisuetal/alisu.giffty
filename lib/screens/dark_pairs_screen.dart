import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giffty_flutter/components/add_item_widget.dart';
import 'package:giffty_flutter/components/button_widget.dart';
import 'package:giffty_flutter/components/dark_pair_form_widget.dart';
import 'package:giffty_flutter/components/dark_pair_list_widget.dart';
import 'package:giffty_flutter/components/header_widget.dart';
import 'package:giffty_flutter/components/modal_widget.dart';
import 'package:giffty_flutter/components/screen_holder_widget.dart';
import 'package:giffty_flutter/components/steps_widget.dart';
import 'package:giffty_flutter/models/dark_pair.dart';
import 'package:giffty_flutter/models/event.dart';
import 'package:giffty_flutter/utils/app_routes.dart';
import 'package:giffty_flutter/utils/palette.dart';
import 'package:provider/provider.dart';

class DarkPairsScreen extends StatefulWidget {
  final String nextIcon = 'assets/imgs/icons/nextIcon.svg';
  final void Function(BuildContext) headerFunction;
  const DarkPairsScreen({Key? key, required this.headerFunction})
      : super(key: key);

  @override
  State<DarkPairsScreen> createState() => _DarkPairsScreenState();
}

class _DarkPairsScreenState extends State<DarkPairsScreen> {
  void _nextScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.INSTRUCTIONS);
  }

  void _openDarkPairModal(BuildContext context, DarkPair? pair, Event event) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return ModalWidget(
            content: DarkPairFormWidget(
          guests: event.guests,
        ));
      },
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      constraints: const BoxConstraints(
        maxHeight: 600.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context, listen: true);
    return ScreenHolderWidget(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                goBack: true,
                headerFunction: widget.headerFunction,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: StepsWidget(step: 3),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  "Would you like to set any Dark Pairs?",
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: DarkPairListWidget(
                  pairs: event.darkPairs,
                  function:
                      (BuildContext context, DarkPair darkPair, Event event) {
                    _openDarkPairModal(context, darkPair, event);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: AddItemWidget(
                  text: "Add Dark Pair",
                  function: () => _openDarkPairModal(context, null, event),
                ),
              ),
            ],
          ),
          if (event.darkPairs.isEmpty)
            SvgPicture.asset(
              "assets/imgs/illustrations/darkPairIllustration.svg",
              height: 128,
              fit: BoxFit.fitWidth,
              // color: Colors.white60,
            ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: ButtonWidget(
              text: event.darkPairs.isEmpty ? "Skip" : "Next",
              materialIcon: Icons.arrow_forward_rounded,
              function: () => _nextScreen(context),
              enabled: true,
            ),
          )
        ],
      ),
    );
  }
}
