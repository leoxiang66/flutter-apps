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

Map<String, dynamic> readMapFromTOMLSync(String TOMLPath) {
  File configFile = File(TOMLPath);
  if (configFile.existsSync()) {
    String contents = configFile.readAsStringSync();
    TomlDocument document = TomlDocument.parse(contents);
    return document.toMap();
  } else {
    throw Exception('File does not exist at path: $TOMLPath');
  }
}

Future<Map<String, dynamic>> readMapFromTOMLAsync(String TOMLPath) async {
  File configFile = File(TOMLPath);
  if (await configFile.exists()) {
    String contents = await configFile.readAsString();
    TomlDocument document = TomlDocument.parse(contents);
    return document.toMap();
  } else {
    throw Exception('File does not exist at path: $TOMLPath');
  }
}

