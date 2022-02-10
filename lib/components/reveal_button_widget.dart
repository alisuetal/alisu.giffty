import 'package:flutter/material.dart';
import 'package:giffty_flutter/components/button_widget.dart';
import 'package:giffty_flutter/components/fake_textfield_widget.dart';
import 'package:giffty_flutter/models/pair.dart';
import 'package:giffty_flutter/utils/palette.dart';
import 'package:giffty_flutter/utils/tools.dart';

class RevealButtonWidget extends StatefulWidget {
  final Pair pair;
  final bool shouldNextPair;
  final void Function(String gOne, String? gTwo) setTitle;
  final void Function(void Function() function) resetFunction;
  final void Function(BuildContext context) buttonFunction;

  const RevealButtonWidget({
    Key? key,
    required this.pair,
    required this.shouldNextPair,
    required this.setTitle,
    required this.resetFunction,
    required this.buttonFunction,
  }) : super(key: key);

  @override
  State<RevealButtonWidget> createState() => _RevealButtonWidgetState();
}

class _RevealButtonWidgetState extends State<RevealButtonWidget> {
  bool visible = true;
  double height = 0;
  double opacity = 1;
  late void Function() function = _revealPair;

  void _resetState() {
    setState(() {
      visible = true;
      height = 0;
      opacity = 1;
    });
  }

  void _revealPair() {
    if (height == 500) {
      setState(() {
        opacity = 0;
        widget.setTitle(widget.pair.pair[0].name, widget.pair.pair[1].name);
        Future.delayed(
          const Duration(milliseconds: 1200),
          () => setState(
            () {
              visible = false;
            },
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gift suggestion:",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FakeTextfieldWidget(
                          text: widget.pair.pair[1].desiredGift),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Gift price (approx.):",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FakeTextfieldWidget(
                          text: Tools()
                              .formatPrice(widget.pair.pair[1].approxPrice)),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
                ButtonWidget(
                  text: "Next",
                  materialIcon: Icons.arrow_forward_rounded,
                  function: widget.shouldNextPair
                      ? () => widget.resetFunction(_resetState)
                      : () => widget.buttonFunction(context),
                  enabled: true,
                )
              ],
            ),
            if (visible)
              AnimatedOpacity(
                opacity: opacity,
                duration: Duration(seconds: 1),
                child: GestureDetector(
                  onTapDown: (TapDownDetails) {
                    setState(() {
                      height = 500;
                    });
                  },
                  onLongPressDown: (TapDownDetails) {
                    setState(() {
                      Future.delayed(
                          Duration(milliseconds: 1400), () => _revealPair());
                    });
                  },
                  onLongPressUp: () {
                    setState(() {
                      height = 0;
                    });
                  },
                  onTapUp: (TapUpDetails) {
                    setState(() {
                      height = 0;
                    });
                  },
                  child: Container(
                    height: 488,
                    decoration: const BoxDecoration(
                      color: PaletteColor.palette,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          const Center(
                            child: Text(
                              "Hold to reveal",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: AnimatedSize(
                                  curve: Curves.linear,
                                  child: Container(
                                    width: double.infinity,
                                    height: height,
                                    decoration: const BoxDecoration(
                                      color: Colors.black12,
                                    ),
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        )
      ],
    );
  }
}
