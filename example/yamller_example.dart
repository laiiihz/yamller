import 'dart:io';

import 'package:yamller/yamller.dart';

//API usage
void main() async {
  var file = File('./example/test.yaml');
  var yamller = Yamller();
  var yaml = await yamller.parse(file);
  yamller.toClass(yaml);
  var store = File('./example/test.g.dart');
  if (!await store.exists()) {
    await store.create();
  }
  await store.writeAsString(yamller.toString());
}
