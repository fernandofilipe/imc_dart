import 'package:imc_dart/exceptions/invalid_height_exception.dart';
import 'package:imc_dart/exceptions/invalid_number_exception.dart';
import 'package:imc_dart/exceptions/invalid_weight_exception.dart';

class Person {
  String _name = "";
  double _weight = 0.0;
  double _height = 0.0;

  Person(this._name);

  void setName(String name) {
    _name = name;
  }

  String getName() {
    return _name;
  }

  void setWeight(String inputedWeight) {
    try {
      if (inputedWeight == '') throw InvalidNumberException();

      double? parsedWeight = double.tryParse(inputedWeight);

      if (parsedWeight == null) throw InvalidNumberException();
      if (parsedWeight == 0) throw InvalidWeightException();

      _weight = parsedWeight;
    } on InvalidNumberException {
      print(InvalidNumberException());
    } on InvalidWeightException {
      print(InvalidWeightException());
    } catch (e) {
      print(e);
    }
  }

  double getWeight() {
    return _weight;
  }

  void setHeight(String inputedHeight) {
    try {
      if (inputedHeight == '') throw InvalidNumberException();

      double? parsedHeight = double.tryParse(inputedHeight);

      if (parsedHeight == null) throw InvalidNumberException();
      if (parsedHeight == 0) throw InvalidHeightException();

      _height = parsedHeight;
    } on InvalidNumberException {
      print(InvalidNumberException());
    } on InvalidHeightException {
      print(InvalidHeightException());
    } catch (e) {
      print(e);
    }
  }

  double getHeight() {
    return _height;
  }

  @override
  String toString() {
    String separator = '\n|-----------|\n';
    List<String> attributes = [
      'nome: $_name',
      'peso: $_weight',
      'altura: $_height',
    ];

    String result = attributes.reduce((acc, element) => '$acc\n$element');
    return '$separator$result$separator';
  }
}
