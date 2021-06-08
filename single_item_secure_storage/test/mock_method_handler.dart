import 'package:flutter/services.dart';

Future<dynamic>? Function(MethodCall call)? mockMethodHandler() {
  var value;

  return (MethodCall methodCall) async {
    if (methodCall.method == 'write') {
      return value = methodCall.arguments['value'];
    }

    if (methodCall.method == 'read') {
      return value;
    }

    if (methodCall.method == 'delete') {
      value = null;
      return null;
    }

    return null;
  };
}
