import 'package:flutter/material.dart';

class StepsWidget extends StatelessWidget {
  final int step;
  const StepsWidget({Key? key, required this.step}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 6,
              width: 40,
              decoration: BoxDecoration(
                color: step == 1
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.16),
                borderRadius: const BorderRadius.all(
                  Radius.circular(3),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Container(
                height: 6,
                width: 40,
                decoration: BoxDecoration(
                  color: step == 2
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.16),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
            ),
            Container(
              height: 6,
              width: 40,
              decoration: BoxDecoration(
                color: step == 3
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.16),
                borderRadius: const BorderRadius.all(
                  Radius.circular(3),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
