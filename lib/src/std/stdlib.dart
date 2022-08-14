import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart' as ffi;

import '../platform.dart';
import '../util.dart';
import 'std.dart';

mixin StdStdlibMixin on PlatformLibC {
  @override
  String? getenv(String name) {
    return ffi.using((arena) {
      final ptr = std.getenv(name.toCString(arena));
      return ptr == ffi.nullptr ? null : ptr.toDartString();
    });
  }

  @override
  void putenv(String str) {
    final res = ffi.using((arena) {
      return std.putenv(str.toCString(arena));
    });
    checkErrno('putenv', res);
  }

  @override
  void setenv(String name, String value, bool overwrite) {
    final res = ffi.using((arena) {
      return std.setenv(
        name.toCString(arena),
        value.toCString(arena),
        overwrite ? 1 : 0,
      );
    });
    checkErrno('setenv', res);
  }

  @override
  void unsetenv(String name) {
    final res = ffi.using((arena) {
      return std.unsetenv(name.toCString(arena));
    });
    checkErrno('unsetenv', res);
  }
}
