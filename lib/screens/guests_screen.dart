import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giffty_flutter/components/add_item_widget.dart';
import 'package:giffty_flutter/components/button_widget.dart';
import 'package:giffty_flutter/components/guest_list_widget.dart';
import 'package:giffty_flutter/components/guest_form_widget.dart';
import 'package:giffty_flutter/components/header_widget.dart';
import 'package:giffty_flutter/components/modal_widget.dart';
import 'package:giffty_flutter/components/screen_holder_widget.dart';
import 'package:giffty_flutter/components/steps_widget.dart';
import 'package:giffty_flutter/models/event.dart';
import 'package:giffty_flutter/models/guest.dart';
import 'package:giffty_flutter/utils/app_routes.dart';
import 'package:provider/provider.dart';

class GuestsScreen extends StatefulWidget {
  final void Function(BuildContext) headerFunction;
  const GuestsScreen({Key? key, required this.headerFunction})
      : super(key: key);

  @override
  State<GuestsScreen> createState() => _GuestsScreenState();
}

class _GuestsScreenState extends State<GuestsScreen> {
  void _nextScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.DARK_PAIRS);
  }

  void _openGuestModal(BuildContext context, Guest? guest) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return ModalWidget(content: GuestFormWidget(guest: guest));
      },
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      constraints: const BoxConstraints(
        maxHeight: 600.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context);
    final guestList = event.guests;
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
                padding: EdgeInsets.only(top: 16),
                child: StepsWidget(step: 2),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  "Set the guests.",
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: GuestListWidget(
                  guests: guestList,
                  function: (BuildContext context, Guest guest) =>
                      _openGuestModal(context, guest),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: AddItemWidget(
                  text: "Add guest",
                  function: () => _openGuestModal(context, null),
                ),
              ),
            ],
          ),
          if (guestList.isEmpty)
            SvgPicture.asset(
              "assets/imgs/illustrations/guestIllustration.svg",
              height: 128,
              fit: BoxFit.fitWidth,
              // color: Colors.white60,
            ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: ButtonWidget(
              text: "Next",
              materialIcon: Icons.arrow_forward_rounded,
              function: () => _nextScreen(context),
              enabled: event.guestCount >= 3,
            ),
          )
        ],
      ),
    );
  }
}
