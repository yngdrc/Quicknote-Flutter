import 'field_type.dart';

abstract class FieldModel {
  FieldModel({required this.fieldType});

  final FieldType fieldType;
}