import 'dart:convert';
import 'dart:io';

class ConsoleUtils {
  final Stdin _localStdin;

  ConsoleUtils(this._localStdin);

  String readStringWithMessage(String message) {
    print(message);
    return _localStdin.readLineSync(encoding: utf8) ?? "";
  }

  String readStringWithMessageAndEscape(String message, String escape) {
    String line = readStringWithMessage(message);
    escapeConsole(line, escape);

    return line;
  }

  void escapeConsole(String line, String escape) {
    if (line == escape) {
      print("Operação cancelada!");
      exit(0);
    }
  }
}
