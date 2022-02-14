import 'package:flutter/material.dart';
import 'package:giffty_flutter/components/button_widget.dart';
import 'package:giffty_flutter/components/dropdown_widget.dart';
import 'package:giffty_flutter/models/dark_pair.dart';
import 'package:giffty_flutter/models/guest.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';

class DarkPairFormWidget extends StatefulWidget {
  final List<Guest> guests;
  final DarkPair? darkpair;
  const DarkPairFormWidget({
    Key? key,
    this.darkpair,
    required this.guests,
  }) : super(key: key);

  @override
  State<DarkPairFormWidget> createState() => _DarkPairFormWidgetState();
}

class _DarkPairFormWidgetState extends State<DarkPairFormWidget> {
  List<List> dropOne = [];
  List<List> dropTwo = [];
  int selectedOne = 0;
  int selectedTwo = 0;

  @override
  void initState() {
    dropOne = _initDropDown();
    dropTwo = _initDropDown();
    dropTwo.removeAt(0);
    selectedOne = dropOne[0][0];
    selectedTwo = dropTwo[0][0];
    super.initState();
  }

  List<List> _initDropDown() {
    return [
      ...widget.guests.map((e) => [int.tryParse(e.id), e.name])
    ];
  }

  void _getFirstDropDown(int value) {
    setState(() {
      selectedOne = value;
      dropTwo = _initDropDown();
      dropTwo.removeWhere((element) => element[0] == value);
      if (selectedTwo == value) {
        selectedTwo = dropTwo[0][0];
      }
    });
  }

  void _getSecondDropDown(int value) {
    setState(() {
      selectedTwo = value;
      dropOne = _initDropDown();
      dropOne.removeWhere((element) => element[0] == value);
      if (selectedOne == value) {
        selectedOne = dropOne[0][0];
      }
    });
  }

  bool _enabledButton(Event event) {
    return event.verifyDarkPair(
        event.guests
            .where((element) => element.id == selectedOne.toString())
            .first,
        event.guests
            .where((element) => element.id == selectedTwo.toString())
            .first);
  }

  void _submit(BuildContext context, Event event, DarkPair? darkPair) {
    if (_enabledButton(event)) {
      if (darkPair != null) {
        event.updateDarkPair(
          darkPair.id,
          widget.guests
              .where((element) => element.id == selectedOne.toString())
              .first,
          widget.guests
              .where((element) => element.id == selectedTwo.toString())
              .first,
        );
      } else {
        event.addDarkPair(
          widget.guests
              .where((element) => element.id == selectedOne.toString())
              .first,
          widget.guests
              .where((element) => element.id == selectedTwo.toString())
              .first,
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DropDownWidget(
            anchor: (int value) {
              _getFirstDropDown(value);
            },
            value: selectedOne,
            items: dropOne,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DropDownWidget(
            anchor: (int value) {
              _getSecondDropDown(value);
            },
            value: selectedTwo,
            items: dropTwo,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ButtonWidget(
            text: widget.darkpair != null ? "Update" : "Add",
            materialIcon: widget.darkpair != null
                ? Icons.refresh_rounded
                : Icons.add_rounded,
            function: () => _submit(context, event, widget.darkpair),
            enabled: _enabledButton(event),
          ),
        )
      ],
    );
  }
}
