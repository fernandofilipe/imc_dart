import 'package:imc_dart/enums/classification_type.dart';
import 'package:imc_dart/exceptions/invalid_height_exception.dart';
import 'package:imc_dart/exceptions/invalid_weight_exception.dart';
import 'package:imc_dart/models/classification.dart';
import 'dart:math' as math;

import 'package:imc_dart/models/person.dart';

class ImcCalculator {
  final Person _person;
  double _imc = 0.0;
  String _classification = '';

  ImcCalculator(this._person);

  String run() {
    _imc = calculate();
    _classification = getClassification();

    return toString();
  }

  double calculate() {
    double weight = _person.getWeight();
    double height = _person.getHeight();

    if (weight <= 0) throw InvalidWeightException();
    if (height <= 0) throw InvalidHeightException();

    return weight / math.pow(height, 2);
  }

  String getClassification() {
    if (_imc < 16) return classification[ClassificationType.magrezaGrave]!;
    if (_imc < 17) return classification[ClassificationType.magrezaModerada]!;
    if (_imc < 18.5) return classification[ClassificationType.magrezaLeve]!;
    if (_imc < 25) return classification[ClassificationType.saudavel]!;
    if (_imc < 30) return classification[ClassificationType.sobrepeso]!;
    if (_imc < 35) return classification[ClassificationType.obsesidadeGrauI]!;
    if (_imc < 40) return classification[ClassificationType.obsesidadeGrauII]!;

    return classification[ClassificationType.obsesidadeGrauIII]!;
  }

  @override
  String toString() {
    List<String> attributes = [
      'nome: ${_person.getName()}',
      'peso: ${_person.getWeight()}',
      'altura: ${_person.getHeight()}',
      'imc: ${_imc.toStringAsFixed(2)}',
      'classificação: $_classification',
    ];

    return attributes.toString();
  }

  String printImcInfo() {
    String separator = '\n|-----------|\n';

    List<String> attributes = [
      'nome: ${_person.getName()}',
      'peso: ${_person.getWeight()}',
      'altura: ${_person.getHeight()}',
      'imc: ${_imc.toStringAsFixed(2)}',
      'classificação: $_classification',
    ];

    String result = attributes.reduce((acc, element) => '$acc\n\r$element');
    return '$separator$result$separator';
  }
}
