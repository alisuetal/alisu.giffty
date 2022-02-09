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
  List<Guest> dropOne = [];
  List<Guest> dropTwo = [];
  String selectedOne = "";
  String selectedTwo = "";

  @override
  void initState() {
    dropOne = [...widget.guests];
    dropTwo = [...widget.guests];
    dropTwo.removeAt(0);
    selectedOne = dropOne[0].id;
    selectedTwo = dropTwo[0].id;
    super.initState();
  }

  void _getFirstDropDown(String value) {
    setState(() {
      selectedOne = value;
      dropTwo.removeWhere((element) => element.id == value);
      if (selectedTwo == value) {
        selectedTwo = dropTwo[0].id;
      }
    });
  }

  void _getSecondDropDown(String value) {
    setState(() {
      selectedTwo = value;
      dropOne.removeWhere((element) => element.id == value);
      if (selectedOne == value) {
        selectedOne = dropOne[0].id;
      }
    });
  }

  bool _enabledButton(Event event) {
    return true;
  }

  void _submit(BuildContext context, Event event, DarkPair? darkPair) {
    if (_enabledButton(event)) {
      if (darkPair != null) {
        event.updateDarkPair(
          darkPair.id,
          dropOne.where((element) => element.id == selectedOne).first,
          dropTwo.where((element) => element.id == selectedTwo).first,
        );
      } else {
        event.addDarkPair(
          dropOne.where((element) => element.id == selectedOne).first,
          dropTwo.where((element) => element.id == selectedTwo).first,
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
            anchor: (String value) {
              _getFirstDropDown(value);
            },
            value: selectedOne,
            guests: event.guests,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DropDownWidget(
            anchor: (String value) {
              _getSecondDropDown(value);
            },
            value: selectedTwo,
            guests: event.guests,
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
