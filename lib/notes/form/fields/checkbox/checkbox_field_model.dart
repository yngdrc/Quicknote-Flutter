import 'package:quicknote/notes/form/fields/field_model.dart';
import 'package:quicknote/notes/form/fields/field_type.dart';

class CheckboxFieldModel implements FieldModel {
  @override
  final FieldType fieldType = FieldType.checkbox;
  bool isChecked = false;
  String text = "";
}