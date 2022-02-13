import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:giffty_flutter/models/event.dart';
import 'package:provider/provider.dart';

class TextFieldWidget extends StatefulWidget {
  final String? text;
  final String hint;
  final void Function(String price) anchor;

  const TextFieldWidget({
    Key? key,
    this.text,
    required this.anchor,
    required this.hint,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final _textController = TextEditingController();

  @override
  void initState() {
    _textController.text = widget.text ?? "0.00";
    _textController.addListener(() {
      widget.anchor(_textController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context, listen: true);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: SizedBox(
        height: 64,
        child: Stack(
          children: [
            TextFormField(
              maxLength: 10,
              inputFormatters: [
                TextInputMask(
                  mask: '9+,999.99',
                  placeholder: '0',
                  maxPlaceHolders: 3,
                  reverse: true,
                ),
              ],
              keyboardType: TextInputType.number,
              controller: _textController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white.withOpacity(0.08),
                counterText: "",
                contentPadding: const EdgeInsets.only(
                  top: 24,
                  left: 24,
                  bottom: 16,
                  right: 64,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    event.currency + " ",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                hintText: widget.hint,
              ),
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white),
              cursorColor: Colors.white,
            ),
            if (_textController.text != "0,00" &&
                _textController.text.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => _textController.text = "0.00",
                          child: Container(
                            height: 28,
                            width: 28,
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: Colors.white.withOpacity(0.08),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
