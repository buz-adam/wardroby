import 'dart:io';

class Filer {
  static Directory _directory;
  Directory _dir;

  Directory get dir => _directory;

  set dir(Directory dir) {
    _directory = dir;
  }
}
