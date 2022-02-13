import 'dart:convert';
import 'package:giffty_flutter/components/dropdown_widget.dart';
import 'package:giffty_flutter/models/event.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomModalWidget extends StatefulWidget {
  const BottomModalWidget({Key? key}) : super(key: key);

  @override
  State<BottomModalWidget> createState() => _BottomModalWidgetState();
}

class _BottomModalWidgetState extends State<BottomModalWidget> {
  late List<List> currencyList;
  int selectedCurrency = 0;

  void _initCurrency() {
    setState(() async {
      currencyList = await _getCurrencies();
    });
  }

  Future<List<List>> _getCurrencies() async {
    List apiData = await http
        .get(Uri.parse('https://openexchangerates.org/api/currencies.json'))
        .then((value) => (json.decode(value.body) as Map).keys.toList());
    List<List> formatData = [];
    for (int x = 0; x < apiData.length; x++) {
      formatData.add([x, apiData[x]]);
    }
    return formatData;
  }

  void _controlCurrency(int value, Event event) {
    if (currencyList[0].length > 1) {
      setState(() {
        selectedCurrency = value;
        event.setCurrency(currencyList[value][1].toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context, listen: false);
    return FutureBuilder(
      future: _getCurrencies(),
      builder: (BuildContext context, AsyncSnapshot<Object> object) {
        currencyList = object.data != null
            ? (object.data as List<List>)
            : [
                [0, "No internet"]
              ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 4,
              ),
              child: Text(
                "Select currency",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            DropDownWidget(
              anchor: (int value) {
                _controlCurrency(value, event);
              },
              value: selectedCurrency,
              items: currencyList,
            ),
          ],
        );
      },
    );
  }
}
