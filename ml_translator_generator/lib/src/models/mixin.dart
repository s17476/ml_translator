import 'package:ml_translator_generator/src/model_visitor.dart';

void createMixin(StringBuffer buffer, ModelVisitor visitor) {
  buffer.writeln('\nmixin _\$${visitor.className} {');

  for (var element in visitor.elements) {
    buffer.writeln(
      'String get ${element.displayName} => throw Exception();',
    );
  }

  buffer.writeln('}');
}
