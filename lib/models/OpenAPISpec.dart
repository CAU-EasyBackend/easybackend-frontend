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
  String version;

  Info.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        version = json['version'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'version': version,
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
    final Map<String, dynamic> data = {};

    if(parameters != null) {
      data['parameters'] = parameters?.map((e) => e.toJson()).toList();
    }
    if(requestBody != null) {
      data['requestBody'] = requestBody?.toJson();
    }
    data['responses'] = responses.map((key, value) => MapEntry(key, value.toJson()));

    return data;
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
  String description;
  Map<String, MediaType> content;

  Response.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        content = (json['content'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, MediaType.fromJson(value)));

  Map<String, dynamic> toJson() {
    return {
      'description': description,
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
      'description': 'new',
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
    final Map<String, dynamic> data = {};

    data['schema'] = schema.toJson();
    if(example != null) {
      data['example'] = example?.toJson();
    }

    return data;
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
    final Map<String, dynamic> data = {};

    data['type'] = type;
    if(items != null) {
      data['items'] = items?.toJson();
    }
    if(properties != null) {
      data['properties'] = properties?.map((key, value) => MapEntry(key, value.toJson()));
    }

    return data;
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
