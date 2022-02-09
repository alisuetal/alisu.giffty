import 'package:flutter/material.dart';
import 'package:giffty_flutter/components/header_widget.dart';
import 'package:giffty_flutter/components/reveal_button_widget.dart';
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
  void _nextScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.END);
  }

  @override
  void initState() {
    currentPair = widget.pairs[0];
    super.initState();
  }

  void _nextPair(void Function() function) {
    if ((index + 1) < widget.pairs.length) {
      setState(() {
        function();
        index++;
        currentPair = widget.pairs[index];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.secondary,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 640,
          ),
          child: SingleChildScrollView(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderWidget(
                        goBack: false, headerFunction: widget.headerFunction),
                    Flexible(
                      child: RevealButtonWidget(
                        pair: currentPair,
                        resetFunction: (void Function() function) =>
                            _nextPair(function),
                        shouldNextPair: _shouldNextPair,
                        buttonFunction: (BuildContext context) =>
                            _nextScreen(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
