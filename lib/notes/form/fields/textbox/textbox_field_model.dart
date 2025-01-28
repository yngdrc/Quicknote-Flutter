import 'package:quicknote/notes/form/fields/field_model.dart';

import '../field_type.dart';

class TextboxFieldModel implements FieldModel {
  @override
  final FieldType fieldType = FieldType.textbox;
  String text = "";
}