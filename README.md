# ArchGen

A CLI tool for generating project structures based on default, MVC, MVVM, or custom architectures.

## Description

ArchGen is a command-line interface (CLI) tool that simplifies the process of creating project structures for Dart applications. It supports four architecture types: Default, MVC, MVVM, and custom. Users can easily specify the desired architecture type and feature name, and ArchGen will generate the necessary files and directories.

## Features

- **Architecture Types**: Choose from Default, MVC, MVVM, or custom architectures.
- **Easy Configuration**: Load architecture definitions from JSON configuration files.
- **Directory and File Creation**: Automatically creates directories and files based on specified architecture.

## Installation

To use ArchGen, ensure you have Dart SDK installed. Then, you can install it via:

```bash
dart pub global activate archgen
```

## Usage

To generate a project structure, use the following command:

```bash
dart run archgen <featureName> [-t default|mvc|mvvm|custom] [<path-to-custom-config>]
```

### Options

- `featureName`: The name of the feature you want to create.
- `-t, --type`: Specify the architecture type:
  - `default`: Default architecture
  - `mvc`: Model-View-Controller
  - `mvvm`: Model-View-ViewModel
  - `custom`: Custom architecture (requires a configuration file path)
- `-h, --help`: Show usage information.

### Examples

- Default usage with Default architecture:
  ```bash
  dart run archgen myFeature -t default
  ```

- MVC architecture:
  ```bash
  dart run archgen myFeature -t mvc
  ```

- MVVM architecture:
  ```bash
  dart run archgen myFeature -t mvvm
  ```

- Custom architecture with a configuration file:
  ```bash
  dart run archgen myFeature -t custom path/to/config.json
  ```
## Customizing the JSON Configuration File

To create a custom architecture, you can provide your own JSON configuration file. The structure of the JSON file must follow the format below, where `feature_name` is a placeholder that will be automatically replaced by the actual feature name specified in the command line.

### Example JSON Structure

```json
{
    "features": {
        "feature_name": {
            "model": {
                "model.dart": "// This is a generated file\n// Model class for feature_name\nclass feature_nameModel {\n  // Add properties here\n}"
            },
            "view": {
                "view.dart": ""
            }
    }
}
```

## Contributing

Contributions are welcome! If you have suggestions for improvements or new features, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Author

**Fellah Mohammed Nassim**  
[Website](https://nassim-fellah.vercel.app/)

---

For any questions or feedback, please reach out via the e-mail found in my website.
