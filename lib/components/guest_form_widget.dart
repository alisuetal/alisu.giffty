import 'package:flutter/material.dart';
import 'package:giffty_flutter/components/button_widget.dart';
import 'package:giffty_flutter/components/text_field_currency_widget.dart';
import 'package:giffty_flutter/components/text_field_string_widget.dart';
import 'package:giffty_flutter/models/guest.dart';
import 'package:giffty_flutter/utils/tools.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';

class GuestFormWidget extends StatefulWidget {
  final Guest? guest;
  const GuestFormWidget({
    Key? key,
    this.guest,
  }) : super(key: key);

  @override
  State<GuestFormWidget> createState() => _GuestFormWidgetState();
}

class _GuestFormWidgetState extends State<GuestFormWidget> {
  String name = "";
  String gift = "";
  String price = "";

  @override
  void initState() {
    name = widget.guest?.name ?? "";
    gift = widget.guest?.desiredGift ?? "";
    price = widget.guest?.approxPrice.toString() ?? "0";
    super.initState();
  }

  void _getName(String value) {
    setState(() {
      name = value;
    });
  }

  void _getGift(String value) {
    setState(() {
      gift = value;
    });
  }

  void _getPrice(String value) {
    setState(() {
      price = value;
    });
  }

  bool _enabledButton(Event event) {
    if (name.isNotEmpty) {
      if (event.price > 0 && Tools().deformatPrice(price) <= event.price) {
        return true;
      } else {
        if (event.price > 0) {
          return false;
        } else {
          return true;
        }
      }
    } else {
      return false;
    }
  }

  void _submit(BuildContext context, Event event, Guest? guest) {
    if (_enabledButton(event)) {
      if (guest != null) {
        event.updateGuest(guest.id, name, gift, Tools().deformatPrice(price));
      } else {
        event.addGuest(name, gift, Tools().deformatPrice(price));
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
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextFieldStringWidget(
              anchor: _getName, hint: "Name", text: widget.guest?.name ?? ""),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextFieldStringWidget(
              anchor: _getGift,
              hint: "Gift suggestion",
              text: widget.guest?.desiredGift ?? ""),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextFieldWidget(
              anchor: _getPrice,
              hint: "Price (optional)",
              text: widget.guest?.approxPrice.toStringAsFixed(2) ?? "0.00"),
        ),
        if (event.price > 0)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Price limit at \$" + event.price.toString(),
              style: const TextStyle(fontSize: 16, color: Colors.white54),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ButtonWidget(
            text: widget.guest != null ? "Update" : "Add",
            materialIcon: widget.guest != null
                ? Icons.refresh_rounded
                : Icons.add_rounded,
            function: () => _submit(context, event, widget.guest),
            enabled: _enabledButton(event),
          ),
        )
      ],
    );
  }
}
