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
                "application/json": {
                  "schema": {
                    "type": "object",
                    "properties": {
                      "result": {
                        "type": "object",
                        "properties": {
                          "message1": {
                            "type": "string"
                          },
                          "message2": {
                            "type": "string"
                          }
                        }
                      }
                    }
                  },
                  "example": {
                    "result": {
                      "message1": "Hello",
                      "message2": "World"
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  ''';

  String changeExample = '''
  {
    "result": {
      "message1": "Hi",
      "message2": "There"
    }
  }
  ''';

  String changeExample2 = '''
  {
    "result": "hi"
  }
  ''';
}
