class OpenAPISpec {
  String openapi;
  Info info;
  Servers servers;
  Paths paths;

  OpenAPISpec.fromJson(Map<String, dynamic> json)
      : openapi = json['openapi'],
        info = Info.fromJson(json['info']),
        servers = Servers.fromJson(json),
        paths = Paths.fromJson(json);

  Map<String, dynamic> toJson() {
    return {
      'openapi': openapi,
      'info': info.toJson(),
      'servers': servers.toJson(),
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

class Servers {
  List<OpenAPIServer> servers;

  Servers.fromJson(Map<String, dynamic> json)
      : servers = (json['servers'] as List)
            .map((e) => OpenAPIServer.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'servers': servers.map((e) => e.toJson()).toList(),
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

class Paths {
  Map<String, Path> paths;

  Paths.fromJson(Map<String, dynamic> json)
      : paths = (json['paths'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, Path.fromJson(value)));

  Map<String, dynamic> toJson() {
    return {
      'paths': paths.map((key, value) => MapEntry(key, value.toJson())),
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
  Parameters? parameters;
  RequestBody? requestBody;
  Responses responses;

  Operation.fromJson(Map<String, dynamic> json)
      : parameters = json['parameters'] != null
            ? Parameters.fromJson(json)
            : null,
        requestBody = json['requestBody'] != null
            ? RequestBody.fromJson(json['requestBody'])
            : null,
        responses = Responses.fromJson(json);

  Map<String, dynamic> toJson() {
    return {
      'parameters': parameters?.toJson(),
      'requestBody': requestBody?.toJson(),
      'responses': responses.toJson(),
    };
  }
}

class Parameters {
  List<Parameter> parameters;

  Parameters.fromJson(Map<String, dynamic> json)
      : parameters = (json['parameters'] as List)
            .map((e) => Parameter.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'parameters': parameters.map((e) => e.toJson()).toList(),
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
  Content content;

  RequestBody.fromJson(Map<String, dynamic> json)
      : content = Content.fromJson(json['content']);

  Map<String, dynamic> toJson() {
    return {
      'content': content.toJson(),
    };
  }
}

class Responses {
  Map<String, Response> responses;

  Responses.fromJson(Map<String, dynamic> json)
      : responses = (json['responses'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, Response.fromJson(value)));

  Map<String, dynamic> toJson() {
    return {
      'responses': responses.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class Response {
  Content content;

  Response.fromJson(Map<String, dynamic> json)
      : content = Content.fromJson(json);

  Map<String, dynamic> toJson() {
    return {
      'content': content.toJson(),
    };
  }
}

class Content {
  Map<String, MediaType> mediaTypes;

  Content.fromJson(Map<String, dynamic> json)
      : mediaTypes = (json['content'] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, MediaType.fromJson(value)));

  Map<String, dynamic> toJson() {
    return {
      'mediaTypes': mediaTypes.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class MediaType {
  Schema schema;

  MediaType.fromJson(Map<String, dynamic> json)
      : schema = Schema.fromJson(json['schema']);

  Map<String, dynamic> toJson() {
    return {
      'schema': schema.toJson(),
    };
  }
}

class Schema {
  String type;

  Schema.fromJson(Map<String, dynamic> json)
      : type = json['type'];

  Map<String, dynamic> toJson() {
    return {
      'type': type,
    };
  }
}
