// default_architecture.dart
const Map<String, dynamic> defaultArchitecture = {
  "core": {
    "api": {
      "api_links.dart": """
        // This is a generated file

        abstract class ApiLinks {
          static const String linkServerName = 'http://  : '; // Add the apis here
        }
      """,
      "api_service.dart": """
        // This is a generated file
        // It uses the Dio package for HTTP requests.
        // Ensure Dio is included in your project dependencies

        import 'dart:io';
        import 'package:dio/dio.dart';

        class ApiService {
          final Dio _dio;

          ApiService(this._dio);

          Future<Map<String, dynamic>> get({
            required String endPoint,
            String? accessToken,
          }) async {
            Map<String, dynamic> headers = {};

            if (accessToken != null) {
              headers['Authorization'] = 'Bearer \$accessToken';
            }

            var response = await _dio.get(
              endPoint,
              options: Options(headers: headers),
            );

            return response.data;
          }

          Future<Map<String, dynamic>> post({
            required String endPoint,
            required Map<String, dynamic> data,
            File? file,
            String? fileName,
            String? accessToken,
          }) async {
            Map<String, dynamic> headers = {
              'Content-type': 'application/json',
              'Accept': 'application/json',
            };

            if (accessToken != null) {
              headers['Authorization'] = 'Bearer \$accessToken';
            }

            FormData formData = FormData.fromMap(data);

            if (file != null) {
              formData.files.add(
                MapEntry(
                  'file',
                  await MultipartFile.fromFile(
                    file.path,
                    filename: fileName,
                  ),
                ),
              );
            }

            var response = await _dio.post(
              endPoint,
              data: formData,
              options: Options(
                headers: headers,
              ),
            );

            return response.data;
          }
        }
      """
    },
    "utils": {
      "helper": {},
      "router": {
        "router.dart": "",
        "route_names.dart": """
          // This is a generated file

          abstract class RouteNames {
            // Add your route names here
            static const String home = 'home';
          }
        """
      }
    },
    "errors": {},
    "theme.dart": "",
    "assets.dart": "",
    "colors.dart": "",
    "other_constants.dart": "",
    "text_styles.dart": """
      // This is a generated file
      import 'package:flutter/material.dart';

      abstract class TextStyles {
        // Add text styles here
      }
    """
  },
  "features": {
    "feature_name": {
      "data": {"models": {}, "repositories": {}},
      "presentation": {
        "manager": {},
        "views": {
          "widgets": {},
          "feature_name.dart": """
            // This is a generated file
            import 'package:flutter/material.dart';

            class feature_name extends StatelessWidget {
              const feature_name({super.key});

              @override
              Widget build(BuildContext context) {
                return const Placeholder();
              }
            }
          """
        }
      }
    }
  }
};
