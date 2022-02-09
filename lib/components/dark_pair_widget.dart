import 'package:flutter/material.dart';
import 'package:giffty_flutter/models/dark_pair.dart';
import 'package:giffty_flutter/models/event.dart';
import 'package:provider/provider.dart';

class DarkPairWidget extends StatelessWidget {
  final DarkPair pair;
  final void Function(BuildContext context, DarkPair darkPair, Event event)
      function;

  const DarkPairWidget({Key? key, required this.pair, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context, listen: false);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 64,
        ),
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.08)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      pair.pair[0].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => event.removeDarkPair(pair),
                    child: Container(
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.delete_rounded,
                          size: 16,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      pair.pair[1].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => function(context, pair, event),
                    child: Container(
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.edit_rounded,
                          size: 16,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
