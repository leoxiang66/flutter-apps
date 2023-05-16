import 'dart:io';
import 'package:toml/toml.dart';
import 'package:path/path.dart' as p;

void writeTOMLSync(Map<String, dynamic> config, String TOMLPath) {
  String toml = TomlDocument.fromMap(config).toString();
  File(TOMLPath).writeAsStringSync(toml);
}


void createConfigTomlIfNotExists({String filepath = 'config.toml'}) {
  File configFile = File(filepath);
  if (!configFile.existsSync()) {
    configFile.createSync();
  }
}



Future<void> writeTOMLAsync(Map<String, dynamic> config, String TOMLPath) async {
  String toml = TomlDocument.fromMap(config).toString();
  await File(TOMLPath).writeAsString(toml);
}

