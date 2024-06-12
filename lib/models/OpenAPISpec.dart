import 'dart:convert';

class OpenAPISpec {
  String openapi;
  Info info;
  List<OpenAPIServer> servers;
  Map<String, Path> paths;

  OpenAPISpec.fromJson(Map<String, dynamic> json)
      : openapi = json['openapi'],
        info = Info.fromJson(json['info']),
        servers = (json['servers'] as List)
            .map((e) => OpenAPIServer.fromJson(e))
            .toList(),
        paths = (json['paths'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, Path.fromJson(value)));

  Map<String, dynamic> toJson() {
    return {
      'openapi': openapi,
      'info': info.toJson(),
      'servers': servers.map((e) => e.toJson()).toList(),
      'paths': paths.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class Info {
  String title;

  Info.fromJson(Map<String, dynamic> json)
      : title = json['title'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}

class OpenAPIServer {
  String url;

  OpenAPIServer.fromJson(Map<String, dynamic> json)
      : url = json['url'];

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}

class Path {
  Map<String, Operation> operations;

  Path.fromJson(Map<String, dynamic> json)
      : operations = json
            .map((key, value) => MapEntry(key, Operation.fromJson(value)));

  Map<String, dynamic> toJson() {
    return operations.map((key, value) => MapEntry(key, value.toJson()));
  }
}

class Operation {
  List<Parameter>? parameters;
  RequestBody? requestBody;
  Map<String, Response> responses;

  Operation.fromJson(Map<String, dynamic> json)
      : parameters = json['parameters'] != null
            ? (json['parameters'] as List)
                .map((e) => Parameter.fromJson(e))
                .toList()
            : null,
        requestBody = json['requestBody'] != null
            ? RequestBody.fromJson(json['requestBody'])
            : null,
        responses = (json['responses'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, Response.fromJson(value)));

  Map<String, dynamic> toJson() {
    return {
      'parameters': parameters?.map((e) => e.toJson()).toList(),
      'requestBody': requestBody?.toJson(),
      'responses': responses.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class Parameter {
  String name;
  String in_;
  bool required;
  Schema schema;

  Parameter.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        in_ = json['in'],
        required = json['required'] ?? false,
        schema = Schema.fromJson(json['schema']);

  Map<String, dynamic> toJson() {
    return {
      'in': in_,
      'name': name,
      'required': required,
      'schema': schema.toJson(),
    };
  }
}

class RequestBody {
  Map<String, MediaType> content;

  RequestBody.fromJson(Map<String, dynamic> json)
      : content = (json['content'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, MediaType.fromJson(value)));

  Map<String, dynamic> toJson() {
    return {
      'content': content.map((key, value) => MapEntry(key, value.toJson())),
    };
  }

  static RequestBody createRequestBodyByExample(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);

    Schema schema = Schema.createSchemaByExample(json);
    Example example = Example.fromJson(json);
    MediaType mediaType = MediaType.fromJson({
      'schema': schema.toJson(),
      'example': example.toJson(),
    });

    return RequestBody.fromJson({
      'content': {
        'application/json': mediaType.toJson(),
      }
    });
  }
}

class Response {
  Map<String, MediaType> content;

  Response.fromJson(Map<String, dynamic> json)
      : content = (json['content'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, MediaType.fromJson(value)));

  Map<String, dynamic> toJson() {
    return {
      'content': content.map((key, value) => MapEntry(key, value.toJson())),
    };
  }

  static Response createResponseByExample(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);

    Schema schema = Schema.createSchemaByExample(json);
    Example example = Example.fromJson(json);
    MediaType mediaType = MediaType.fromJson({
      'schema': schema.toJson(),
      'example': example.toJson(),
    });

    return Response.fromJson({
      'content': {
        'application/json': mediaType.toJson(),
      }
    });
  }
}

class MediaType {
  Schema schema;
  Example? example;

  MediaType.fromJson(Map<String, dynamic> json)
      : schema = Schema.fromJson(json['schema']),
        example = json['example'] != null ? Example.fromJson(json['example']) : null;

  Map<String, dynamic> toJson() {
    return {
      'schema': schema.toJson(),
      'example': example?.toJson(),
    };
  }
}

class Schema {
  String type;
  Schema? items;
  Map<String, Schema>? properties;

  Schema.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        items = json['items'] != null ? Schema.fromJson(json['items']) : null,
        properties = json['properties'] != null
            ? (json['properties'] as Map<String, dynamic>)
                .map((key, value) => MapEntry(key, Schema.fromJson(value)))
            : null;

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'items': items?.toJson(),
      'properties': properties?.map((key, value) => MapEntry(key, value.toJson())),
    };
  }

  static Schema createSchemaByExample(dynamic value) {
    if(value is Map<String, dynamic>) {
      return Schema.fromJson({
        'type': 'object',
        'properties': value.map((k, v) => MapEntry(k, Schema.createSchemaByExample(v).toJson())),
      });
    } else if(value is List) {
      return Schema.fromJson({
        'type': 'array',
        'items': Schema.createSchemaByExample(value[0]),
      });
    } else {
      return Schema.fromJson({
        'type': 'string'
      });
    }
  }
}

class Example {
  Map<String, dynamic> value;

  Example.fromJson(Map<String, dynamic> json)
      : value = _parseJson(json);

  static Map<String, dynamic> _parseJson(Map<String, dynamic> json) {
    Map<String, dynamic> result = {};
    for(var key in json.keys) {
      if(json[key] is Map<String, dynamic>) {
        result[key] = _parseJson(json[key]);
      } else {
        result[key] = json[key].toString();
      }
    }
    return result;
  }

  Map<String, dynamic> toJson() {
    return value;
  }
}
