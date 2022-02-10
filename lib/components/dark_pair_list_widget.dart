import 'package:flutter/material.dart';
import 'package:giffty_flutter/components/dark_pair_widget.dart';
import 'package:giffty_flutter/models/dark_pair.dart';
import 'package:giffty_flutter/models/event.dart';

class DarkPairListWidget extends StatelessWidget {
  final List<DarkPair> pairs;
  final void Function(BuildContext context, DarkPair darkPair, Event event)
      function;

  const DarkPairListWidget({
    Key? key,
    required this.pairs,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.48 < 320
              ? 320
              : MediaQuery.of(context).size.height * 0.48,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: pairs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: DarkPairWidget(pair: pairs[index], function: function),
            );
          },
        ),
      ),
    );
  }
}
