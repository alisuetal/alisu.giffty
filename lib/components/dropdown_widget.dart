import 'package:flutter/material.dart';
import 'package:giffty_flutter/models/guest.dart';
import 'package:giffty_flutter/utils/palette.dart';

class DropDownWidget extends StatefulWidget {
  final List<List> items;
  final int value;
  final void Function(int value) anchor;

  const DropDownWidget({
    Key? key,
    required this.value,
    required this.items,
    required this.anchor,
  }) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: SizedBox(
        height: 64,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
          ),
          child: Center(
            child: DropdownButton<int>(
              value: widget.value,
              focusColor: Colors.white.withOpacity(0),
              icon: const Padding(
                padding: EdgeInsets.only(
                  right: 8,
                ),
                child: Icon(Icons.keyboard_arrow_down_rounded),
              ),
              dropdownColor: PaletteColor.secondary,
              isExpanded: true,
              style: Theme.of(context).textTheme.headline3,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              underline: Container(),
              onChanged: (int? newValue) {
                widget.anchor(newValue!);
              },
              items: [...widget.items].toList().map<DropdownMenuItem<int>>(
                (List item) {
                  return DropdownMenuItem<int>(
                    value: item[0],
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: Text(item[1]),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
