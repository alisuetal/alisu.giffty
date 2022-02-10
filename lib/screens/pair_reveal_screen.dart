import 'package:flutter/material.dart';
import 'package:giffty_flutter/components/header_widget.dart';
import 'package:giffty_flutter/components/reveal_button_widget.dart';
import 'package:giffty_flutter/components/screen_holder_widget.dart';
import 'package:giffty_flutter/models/pair.dart';
import 'package:giffty_flutter/utils/app_routes.dart';
import 'package:giffty_flutter/utils/palette.dart';

class PairRevealScreen extends StatefulWidget {
  final void Function(BuildContext) headerFunction;
  final List<Pair> pairs;
  const PairRevealScreen({
    Key? key,
    required this.headerFunction,
    required this.pairs,
  }) : super(key: key);

  @override
  State<PairRevealScreen> createState() => _PairRevealScreenState();
}

class _PairRevealScreenState extends State<PairRevealScreen> {
  late Pair currentPair;
  late int index = 0;
  late String title = "";
  void _nextScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.END);
  }

  @override
  void initState() {
    currentPair = widget.pairs[0];
    _setTitle(currentPair.pair[0].name, null);
    super.initState();
  }

  void _nextPair(void Function() function) {
    if ((index + 1) < widget.pairs.length) {
      setState(() {
        function();
        index++;
        currentPair = widget.pairs[index];
        _setTitle(currentPair.pair[0].name, null);
      });
    }
  }

  bool get _shouldNextPair {
    if ((index + 1) < widget.pairs.length) {
      return true;
    } else {
      return false;
    }
  }

  void _setTitle(String gOne, String? gTwo) {
    if (gTwo != null) {
      setState(() {
        title = gOne + " got " + gTwo + "!";
      });
    } else {
      setState(() {
        title = gOne + " got...";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenHolderWidget(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                goBack: true,
                headerFunction: widget.headerFunction,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Text(
                  title, //widget.pair.pair[0].name + " got...",
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            child: RevealButtonWidget(
              pair: currentPair,
              setTitle: (String gOne, String? gTwo) => _setTitle(gOne, gTwo),
              resetFunction: (void Function() function) => _nextPair(function),
              shouldNextPair: _shouldNextPair,
              buttonFunction: (BuildContext context) => _nextScreen(context),
            ),
          ),
        ],
      ),
    );
  }
}
