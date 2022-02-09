import 'package:flutter/material.dart';
import 'package:giffty_flutter/models/event.dart';
import 'package:giffty_flutter/models/guest.dart';
import 'package:provider/provider.dart';

class GuestWidget extends StatelessWidget {
  final Guest guest;
  final void Function(BuildContext context, Guest guest) function;

  const GuestWidget({
    Key? key,
    required this.guest,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context);
    return Container(
      constraints: const BoxConstraints(
        minHeight: 64,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                guest.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () => function(context, guest),
                  child: Container(
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.edit_rounded,
                        size: 16,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () => event.removeGuest(guest),
                  child: Container(
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.delete_rounded,
                        size: 16,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
