import 'dart:io';

import 'package:imc_dart/exceptions/invalid_height_exception.dart';
import 'package:imc_dart/exceptions/invalid_name_exception.dart';
import 'package:imc_dart/exceptions/invalid_weight_exception.dart';
import 'package:imc_dart/helpers/console_utils.dart';
import 'package:imc_dart/models/imc_calculator.dart';
import 'package:imc_dart/models/person.dart';

import 'dart:developer' as developer;

void execute() {
  ConsoleUtils consoleUtils = ConsoleUtils(stdin);
  String name = consoleUtils.readStringWithMessage('Digite seu nome:');

  try {
    if (name.trim() == '') throw InvalidNameException();

    Person person = Person(name);

    do {
      String inputedWeight = consoleUtils.readStringWithMessageAndEscape(
          'Digite seu peso (em quilos), ou s para Sair:', 's');

      person.setWeight(inputedWeight);
    } while (person.getWeight() == 0);

    do {
      String inputedHeight = consoleUtils.readStringWithMessageAndEscape(
          'Digite sua altura (em metros), ou s para Sair:', 's');

      person.setHeight(inputedHeight);
    } while (person.getHeight() == 0);

    ImcCalculator imcCalculator = ImcCalculator(person);
    String result = imcCalculator.run();
    print(result);
  } on InvalidNameException {
    print(InvalidNameException());
    exit(0);
  } on InvalidWeightException {
    print(InvalidWeightException());
    exit(0);
  } on InvalidHeightException {
    print(InvalidHeightException());
    exit(0);
  } catch (e) {
    print(e);
    developer.log(e.toString(),
        name: 'IMC Dart - Logger', error: 'Método Execute');
    exit(0);
  }
}
