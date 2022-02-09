import 'package:flutter/material.dart';
import 'package:giffty_flutter/components/guest_widget.dart';
import 'package:giffty_flutter/models/guest.dart';

class GuestListWidget extends StatelessWidget {
  final List<Guest> guests;
  final void Function(BuildContext context, Guest guest) function;

  const GuestListWidget({
    Key? key,
    required this.guests,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: guests.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: GuestWidget(guest: guests[index], function: function),
        );
      },
    );
  }
}
