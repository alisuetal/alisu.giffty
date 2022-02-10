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
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.48 < 304
              ? 304
              : MediaQuery.of(context).size.height * 0.48,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: guests.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GuestWidget(guest: guests[index], function: function),
            );
          },
        ),
      ),
    );
  }
}
