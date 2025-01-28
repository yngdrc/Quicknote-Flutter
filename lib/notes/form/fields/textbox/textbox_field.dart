import 'package:flutter/material.dart';
import 'package:quicknote/notes/form/fields/textbox/textbox_field_model.dart';

class TextboxField extends StatefulWidget {
  const TextboxField(
      {super.key, required this.initialModel, required this.focusNode});

  final TextboxFieldModel initialModel;
  final FocusNode focusNode;

  @override
  State<StatefulWidget> createState() => _TextboxFieldState();
}

class _TextboxFieldState extends State<TextboxField> {
  _TextboxFieldState();

  late TextboxFieldModel _model;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _model = widget.initialModel;
    _controller = TextEditingController();
    _controller.text = _model.text;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      autofocus: true,
      focusNode: widget.focusNode,
      minLines: 1,
      maxLines: null,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      onChanged: (value) => setState(() => _model.text = value),
    );
  }
}
