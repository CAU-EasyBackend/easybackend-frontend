import 'dart:convert';

import 'package:easyback/models/OpenAPISpec.dart';

void main() {
  String jsonString = '''
  {
    "openapi": "3.0.0",
    "info": {
      "title": "Echo API",
      "version": "1.0.0",
      "description": "A simple API to echo a text response"
    },
    "servers": [
      {
        "url": "http://localhost:8080"
      }
    ],
    "paths": {
      "/echo": {
        "get": {
          "summary": "Echo a text response",
          "description": "Returns a simple text response \\"ver.1\\"",
          "parameters": [
            {
              "in": "header",
              "name": "Accept",
              "required": true,
              "schema": {
                "type": "string",
                "default": "text/plain"
              }
            }
          ],
          "responses": {
            "200": {
              "description": "Successful response",
              "content": {
                "text/plain": {
                  "schema": {
                    "type": "string"
                  },
                  "example": "ver.1"
                }
              }
            }
          }
        }
      }
    }
  }
  ''';

  Map<String, dynamic> json = jsonDecode(jsonString);
  OpenAPISpec openAPISpec = OpenAPISpec.fromJson(json);

  print(openAPISpec.openapi);
  print(openAPISpec.info.title);
  print(openAPISpec.servers.servers[0].url);

  Paths paths = openAPISpec.paths;
  for(String path in paths.paths.keys) {
    print(path);
    Path elem = paths.paths[path] as Path;
    Operation get = elem.operations['get'] as Operation;

    Parameters parameters = get.parameters!;
    for(Parameter param in parameters.parameters) {
      print(param.name);
      print(param.in_);
      print(param.required);
      print(param.schema.type);
    }

    Responses responses = get.responses;
    for(String status in responses.responses.keys) {
      print(status);
      Response response = responses.responses[status] as Response;

      Content content = response.content;
      for(String type in content.mediaTypes.keys) {
        print(type);
        MediaType mediaType = content.mediaTypes[type] as MediaType;
        print(mediaType.schema.type);
      }
    }
  }
}
