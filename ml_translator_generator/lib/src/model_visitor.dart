import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  String className = '';
  List<Element> elements = [];

  @override
  void visitConstructorElement(ConstructorElement element) {
    final returnType = element.returnType.toString();

    className = returnType.replaceFirst('*', '');

    elements = element.children;

    if (elements.isEmpty) {
      throw Exception(
        '$className constructor should contain at least one field!',
      );
    }
  }

  @override
  void visitFieldElement(FieldElement element) async {
    final fields = {};

    fields[element.name] = element.type.toString().replaceFirst('*', '');

    if (fields.isEmpty) {
      throw Exception('$className can not contain any fields!');
    }
  }
}
