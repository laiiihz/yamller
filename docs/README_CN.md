# YAMMLER

从yaml配置文件生成dart配置文件

## 使用

### 从pub安装
```shell
dart pub global activate yamller
```

### 命令行 
```shell
yamller --files=[your config yaml file].yaml
```

### 例子

* yaml file (test.yaml)

```yaml
name: test_pubspec
description: test_pubspec
publish_to: "none"
version: 1.0.0+10
environment:
  sdk: ">=2.12.0 <3.0.0"
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  cupertino_icons: ^1.0.2
  dio: ^4.0.0
dev_dependencies:
  build_runner: ^2.1.0
flutter:
  uses-material-design: true
```

* 生成dart配置文件 (test.dart)

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// YAMMLER GENERATOR
// https://github.com/laiiihz/yamller
// https://pub.dev/packages/yamller
// **************************************************************************
class Test {
  const Test();

  static const String name = 'test_pubspec';

  static const String description = 'test_pubspec';

  static const String publishTo = 'none';

  static const String version = '1.0.0+10';

  static final environment = const _Environment0();

  static final dependencies = const _Dependencies1();

  static final devDependencies = const _DevDependencies4();

  static final flutter = const _Flutter5();
}

class _Flutter5 {
  const _Flutter5();

  final bool usesMaterialDesign = true;
}

class _DevDependencies4 {
  const _DevDependencies4();

  final String buildRunner = '^2.1.0';
}

class _Dependencies1 {
  const _Dependencies1();

  final flutter = const _Flutter1();

  final flutterLocalizations = const _FlutterLocalizations2();

  final String cupertinoIcons = '^1.0.2';

  final String dio = '^4.0.0';
}

class _FlutterLocalizations2 {
  const _FlutterLocalizations2();

  final String sdk = 'flutter';
}

class _Flutter1 {
  const _Flutter1();

  final String sdk = 'flutter';
}

class _Environment0 {
  const _Environment0();

  final String sdk = '>=2.12.0 <3.0.0';
}
```

* 配置文件使用

```dart
final String name = Test.name; // test_pubspec
final String sdk = Test.environment.sdk; // >=2.12.0 <3.0.0
```

## API 使用

[yamller API documentation](https://pub.dev/documentation/yamller/latest/)

## 里程碑

* 0.1.0
  * [ ] 更多配置选项
  * [ ] 使用 `build_runner` 生成代码
* 0.2.0
  * [ ] 支持 Yaml List 

## 功能和问题

[issue tracker][tracker]

[tracker]: https://github.com/laiiihz/yamller/issues
