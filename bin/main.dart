import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';
import 'package:yamller/yamller.dart';

void main(List<String> args) async {
  final argParser = ArgParser()
    ..addMultiOption('files')
    ..addFlag('help', abbr: 'h', negatable: false);

  final result = argParser.parse(args);

  if (result['help']) {
    print(argParser.usage);
    return;
  }
  for (var item in result['files']) {
    final newPath = (item as String).replaceAll(extension(item), '.dart');
    final yamller = Yamller();
    final map = await yamller.parse(File(item));
    yamller.toClass(map);
    var store = File(newPath);
    if (!await store.exists()) {
      await store.create();
    }
    print(store.absolute.path);
    await store.writeAsString(yamller.toString());
  }
}
