import 'package:flutter/material.dart';
import 'package:quicknote/notes/form/fields/checkbox/checkbox_field_model.dart';

class CheckboxField extends StatefulWidget {
  const CheckboxField(
      {super.key, required this.initialModel, required this.focusNode});

  final CheckboxFieldModel initialModel;
  final FocusNode focusNode;

  @override
  State<StatefulWidget> createState() => _CheckboxFieldState();
}

class _CheckboxFieldState extends State<CheckboxField> {
  late CheckboxFieldModel _model;
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
    return Column(
      children: [
        TextField(
          controller: _controller,
          autofocus: true,
          focusNode: widget.focusNode,
          minLines: 1,
          maxLines: null,
          decoration: InputDecoration(
            icon: Checkbox(
              value: _model.isChecked,
              onChanged: (value) =>
                  setState(() => _model.isChecked = value ?? false),
            ),
            border: InputBorder.none,
          ),
          onChanged: (value) => setState(() => _model.text = value),
        )
      ],
    );
  }
}
