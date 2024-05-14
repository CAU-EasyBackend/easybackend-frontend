import 'dart:io';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart' as swagger_ui;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

void main(List<String> args) async {
  final path = 'specs/swagger.yaml';
  final handler = SwaggerUI(path, title: 'Swagger Test');
  var server = await io.serve(handler, '0.0.0.0', 4001);
  print('Serving at http://${server.address.host}:${server.port}');
}

  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addHandler(_echoRequest);



shelf.Response _echoRequest(shelf.Request request) {
  return shelf.Response.ok('Request for "${request.url}"');
}
