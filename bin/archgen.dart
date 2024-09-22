import 'dart:io';
import 'dart:convert';
import 'package:args/args.dart';

import 'default_architecture.dart';
import 'mvc_architecture.dart';
import 'mvvm_architecture.dart';

/// Main entry point for the CLI tool.
///
void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption('type',
        abbr: 't',
        help: 'Specify the architecture type (mvc|mvvm|custom)',
        allowed: ['mvc', 'mvvm', 'custom'])
    ..addFlag('help',
        abbr: 'h', negatable: false, help: 'Show usage information.');

  ArgResults argResults;
  try {
    // Parse arguments
    argResults = parser.parse(arguments);
  } catch (e) {
    // Catch any parsing errors and show usage
    print('• Error: Invalid arguments provided.');
    printUsage(parser);
    return;
  }

  final featureName = argResults.rest.isNotEmpty ? argResults.rest[0] : null;

  if (featureName == null) {
    print('• Error: Please provide a feature name.');
    printUsage(parser);
    return;
  }

  // Determine architecture based on type
  Map<String, dynamic> architecture;

  final type = argResults['type'] as String?;
  switch (type) {
    case 'mvc':
      architecture = mvcArchitecture;
      break;
    case 'mvvm':
      architecture = mvvmArchitecture;
      break;
    case 'custom':
      // For custom, expect a file path as the next argument after the feature name
      if (argResults.rest.length < 2) {
        print(
            'Error: Please provide the path to the custom config file when using the custom type.');
        return;
      }
      architecture = loadCustomArchitecture(argResults.rest[1])!;

      break;
    default:
      architecture = defaultArchitecture;
  }

  // Create architecture with the provided feature name
  createArchitectureWithFeatureName(architecture, featureName, 'lib');
}

/// Loads custom architecture from a specified JSON file.
///
Map<String, dynamic>? loadCustomArchitecture(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    print('Configuration file does not exist: $path');
    return null;
  }

  final jsonString = file.readAsStringSync();
  return jsonDecode(jsonString) as Map<String, dynamic>;
}

/// Prints the usage information for the CLI tool.
///
void printUsage(ArgParser parser) {
  print('• Usage:');
  print(
      'dart create_architecture.dart <featureName> [-t mvc|mvvm|custom] [<path-to-custom-config>]');
  print('• Examples:');
  print('  Default usage: dart create_architecture.dart myFeature -t mvc');
  print('  MVC architecture: dart create_architecture.dart myFeature -t mvc');
  print('  MVVM architecture: dart create_architecture.dart myFeature -t mvvm');
  print(
      '  Custom architecture with configuration file: dart create_architecture.dart myFeature -t custom <path-to-custom-config>\n');

  print(parser.usage);
}

/// Recursively creates the project structure based on the provided architecture.
///
void createArchitectureWithFeatureName(
    Map<String, dynamic> structure, String featureName,
    [String currentPath = '']) {
  structure.forEach((key, value) {
    final adjustedKey = key.replaceAll('feature_name', featureName);
    final isFile = adjustedKey.endsWith('.dart');
    final path =
        currentPath.isEmpty ? adjustedKey : '$currentPath/$adjustedKey';

    if (isFile) {
      final file = File(path);

      // If it's a file, create it
      if (!file.existsSync()) {
        file.createSync(recursive: true);
        if (value is String) {
          value = value.replaceAllMapped(RegExp(r'feature_name(\w*)'), (match) {
            return '$featureName${match.group(1)}';
          });
          // Write the predefined content to the file
          file.writeAsStringSync(value);
          print('Created file with content: $path');
        } else {
          print('Created file: $path');
        }
      } else {
        print('File already exists: $path');
      }
    } else if (value is Map<String, dynamic>) {
      // If it's a directory, create the directory
      if (!Directory(path).existsSync()) {
        Directory(path).createSync(recursive: true);
        print('Created directory: $path');
      } else {
        print('Directory already exists: $path');
      }
      createArchitectureWithFeatureName(value, featureName, path);
    } else if (value is List) {
      // Handle empty lists (directories)
      if (!Directory(path).existsSync()) {
        Directory(path).createSync(recursive: true);
        print('Created directory: $path');
      }

      // Create any files within the list
      for (var file in value) {
        final filePath = '$currentPath/$file';
        if (!File(filePath).existsSync()) {
          File(filePath).createSync(recursive: true);
          print('Created file: $filePath');
        } else {
          print('File already exists: $filePath');
        }
      }
    } else if (value is Map) {
      // Handle empty maps (create empty directories)
      if (!Directory(path).existsSync()) {
        Directory(path).createSync(recursive: true);
        print('Created directory: $path');
      }
      // Recursively call to handle any nested structures
      createArchitectureWithFeatureName(
          value.cast<String, dynamic>(), featureName, path);
    }
  });
}
