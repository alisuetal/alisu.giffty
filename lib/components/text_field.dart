import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String? text;
  final int type;
  final void Function(String price) anchor;

  const TextFieldWidget({
    Key? key,
    this.text,
    required this.type,
    required this.anchor,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final _textController = TextEditingController();

  @override
  void initState() {
    switch (widget.type) {
      case 1:
        _textController.text = widget.text ?? "0.00";
        break;
      default:
        _textController.text = widget.text ?? "";
    }
    _textController.addListener(() {
      widget.anchor(_textController.text);
    });
    super.initState();
  }

  Widget _prefix(BuildContext context) {
    switch (widget.type) {
      case 1:
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            "\$",
            style: Theme.of(context).textTheme.headline5,
          ),
        );
      default:
        return Container();
    }
  }

  String get _hint {
    switch (widget.type) {
      case 1:
        return "Price (optional)";
      default:
        return "";
    }
  }

  TextInputType get _textInputType {
    switch (widget.type) {
      case 1:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
            keyboardType: _textInputType,
            controller: _textController,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white.withOpacity(0.16),
              counterText: "",
              contentPadding: const EdgeInsets.only(
                top: 24,
                left: 24,
                bottom: 18,
                right: 64,
              ),
              prefix: _prefix(context),
              hintText: _hint,
            ),
            style: Theme.of(context).textTheme.headline5,
            cursorColor: Colors.white,
          ),
          if (_textController.text != "" && _textController.text != "0,00")
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _textController.clear(),
                        child: Container(
                          height: 32,
                          width: 32,
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white24,
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
    );
  }
}
