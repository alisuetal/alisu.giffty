import 'package:flutter/material.dart';
import 'package:giffty_flutter/components/button_widget.dart';
import 'package:giffty_flutter/components/header_widget.dart';
import 'package:giffty_flutter/components/instruction_widget.dart';
import 'package:giffty_flutter/models/event.dart';
import 'package:giffty_flutter/utils/app_routes.dart';
import 'package:giffty_flutter/utils/palette.dart';
import 'package:provider/provider.dart';

class InstructionsScreen extends StatelessWidget {
  final String nextIcon = 'assets/imgs/icons/nextIcon.svg';
  final void Function(BuildContext) headerFunction;
  const InstructionsScreen({Key? key, required this.headerFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _nextScreen(BuildContext context) {
      Navigator.of(context).pushNamed(AppRoutes.PAIR_REVEAL);
    }

    final event = Provider.of<Event>(context, listen: false);
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderWidget(
                          goBack: true,
                          headerFunction: headerFunction,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Text(
                            "Let the games begin!",
                            style: Theme.of(context).textTheme.headline1,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: InstructionWidget(
                            number: "1",
                            text:
                                "Pass the device to the one whom name shows on the screen.",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: InstructionWidget(
                            number: "2",
                            text:
                                "Press and hold the reveal button to show your pair.",
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: InstructionWidget(
                            number: "3",
                            text: "Repeat step 01.",
                          ),
                        ),
                      ],
                    ),
                    ButtonWidget(
                      text: "Next",
                      materialIcon: Icons.arrow_forward_rounded,
                      function: () {
                        _nextScreen(context);
                        event.setPairs();
                      },
                      enabled: true,
                    )
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
