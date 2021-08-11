import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:yaml/yaml.dart';
import 'package:recase/recase.dart';

class Yamller {
  int _identifer = 0;
  String baseClassName = '';
  List<Class> classes = [];

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln(
        '''// **************************************************************************
// YAMMLER GENERATOR
// https://github.com/laiiihz/yamller
// https://pub.dev/packages/yamller
// **************************************************************************''');
    for (var item in classes) {
      buffer.writeln(item.accept(DartEmitter()).toString());
    }
    return DartFormatter().format(buffer.toString());
  }

  ///parse file to YamlMap
  ///
  Future<YamlMap> parse(File file) async {
    baseClassName = file.absolute.uri.pathSegments.last.replaceAll('.yaml', '');
    return loadYaml(await file.readAsString());
  }

  void toClass(YamlMap map, [bool isSub = false, String className = '']) {
    var baseFields = <Field>[];

    for (var item in map.entries) {
      if (item.value is String ||
          item.value is int ||
          item.value is double ||
          item.value is num ||
          item.value is bool) {
        baseFields.add(_toField(item.key, item.value, isSub));
      }
      if (item.value is YamlMap) {
        baseFields.add(Field(
          (f) => f
            ..name = item.key.toString().camelCase
            ..static = !isSub
            ..modifier = FieldModifier.final$
            ..assignment =
                Code('const _${item.key.toString().pascalCase}$_identifer()'),
        ));
        toClass(
          item.value as YamlMap,
          true,
          '_${item.key.toString().pascalCase}$_identifer',
        );
        _identifer++;
      }

      if (item.value is YamlList) {
        //TODO list parse
      }
    }

    var single = Class((c) => c
      ..name = isSub ? className : baseClassName.pascalCase
      ..constructors.add(Constructor((con) => con.constant = true))
      ..fields.addAll(baseFields));
    classes.insert(0, single);
  }

  Field _toField(String key, dynamic value, [bool isSub = false]) {
    var code = Code('\'$value\'');
    if (value is int || value is double || value is num || value is bool) {
      code = Code(value.toString());
    }
    return Field(
      (f) => f
        ..name = key.camelCase
        ..static = !isSub
        ..modifier = isSub ? FieldModifier.final$ : FieldModifier.constant
        ..type = Reference(value.runtimeType.toString())
        ..assignment = code,
    );
  }
}
