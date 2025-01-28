import 'package:flutter/material.dart';
import 'package:quicknote/notes/form/fields/field_model.dart';
import 'package:quicknote/notes/form/fields/field_type.dart';
import 'package:quicknote/notes/form/fields/textbox/textbox_field.dart';
import 'package:quicknote/notes/form/fields/textbox/textbox_field_model.dart';

import '../../navigation/navigation_screen.dart';
import 'fields/checkbox/checkbox_field.dart';
import 'fields/checkbox/checkbox_field_model.dart';

class NotesFormScreen extends StatefulWidget implements NavigationScreen {
  const NotesFormScreen({super.key, required this.navigateTo});

  @override
  final Destination destination = NoteDestination.createNote;

  @override
  final Function(Destination) navigateTo;

  @override
  State<StatefulWidget> createState() => _NotesFormState();
}

class _NotesFormState extends State<NotesFormScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<FieldModel, FocusNode> _fieldModels = {};
  final ScrollController scrollController = ScrollController();

  bool onScrollEndNotification(ScrollEndNotification notification) {
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var focusNode in _fieldModels.values) {
      focusNode.dispose();
    }

    super.dispose();
  }

  FocusNode changeFocus() {
    _fieldModels.removeWhere((fieldModel, focusNode) {
      focusNode.unfocus();
      final isValueEmpty = switch (fieldModel) {
        TextboxFieldModel _ => fieldModel.text.isEmpty,
        CheckboxFieldModel _ => fieldModel.text.isEmpty,
        FieldModel _ => true
      };

      return isValueEmpty;
    });

    final newFocus = FocusNode();
    newFocus.requestFocus();
    return newFocus;
  }

  void saveChanges() {}

  void addField() {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: FieldType.values.map((fieldType) {
              return TextButton(
                  onPressed: () {
                    final fieldModel = switch (fieldType) {
                      FieldType.textbox => TextboxFieldModel(),
                      FieldType.checkbox => CheckboxFieldModel()
                    };

                    setState(() =>
                        _fieldModels.putIfAbsent(fieldModel, changeFocus));
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(fieldType.name),
                  ));
            }).toList(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            onPressed: saveChanges,
            child: const Icon(Icons.check),
          ),
          FloatingActionButton.small(
            onPressed: addField,
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (notification) => onScrollEndNotification(notification),
        child: GestureDetector(
          child: ListView.builder(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _fieldModels.length,
            itemBuilder: (context, index) {
              final fieldModel = _fieldModels.keys.elementAt(index);
              final focusNode = _fieldModels.values.elementAt(index);
              final field = switch (fieldModel) {
                TextboxFieldModel _ => TextboxField(
                    initialModel: fieldModel,
                    focusNode: focusNode,
                  ),
                CheckboxFieldModel _ => CheckboxField(
                    initialModel: fieldModel,
                    focusNode: focusNode,
                  ),
                FieldModel _ => throw UnimplementedError(),
              };

              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 15,
                ),
                child: field,
              );
            },
          ),
        ),
      ),
    );
  }
}
