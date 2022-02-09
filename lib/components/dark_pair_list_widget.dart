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
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pairs.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: DarkPairWidget(pair: pairs[index], function: function),
        );
      },
    );
  }
}
