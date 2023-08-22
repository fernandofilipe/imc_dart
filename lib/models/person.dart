import 'package:imc_dart/exceptions/invalid_weight_exception.dart';

class Person {
  String _name = "";
  double _weight = 0.0;
  double _height = 0.0;

  Person(this._name, this._weight, this._height);

  void setName(String name) {
    _name = name;
  }

  String getName() {
    return _name;
  }

  void setWeight(double weight) {
    _weight = weight;
  }

  double getWeight() {
    return _weight;
  }

  void setHeight(double height) {
    _height = height;
  }

  double getHeight() {
    return _height;
  }

  double calculateIMC() {
    if (_weight <= 0) throw InvalidWeightException();
    if (_height <= 0) throw InvalidWeightException();

    return _weight / (_height * _height);
  }

  @override
  String toString() {
    return 'nome: $_name - peso: $_weight - altura: $_height';
  }
}
