import 'dart:io';

import 'package:imc_dart/exceptions/invalid_height_exception.dart';
import 'package:imc_dart/exceptions/invalid_weight_exception.dart';
import 'package:imc_dart/models/imc_calculator.dart';
import 'package:imc_dart/models/person.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  group("Should calculate IMC with valid entries.", () {
    String testerName = 'Tester Jr.';

    var valuesToTest = {
      {
        'weight': '55',
        'height': 1.50,
        'response':
            '[nome: $testerName, peso: 55.0, altura: 1.5, imc: 24.44, classificação: Saudável]'
      },
      {
        'weight': '30',
        'height': 1.80,
        'response':
            '[nome: $testerName, peso: 30.0, altura: 1.8, imc: 9.26, classificação: Magreza Grave]'
      },
      {
        'weight': '90',
        'height': 1.80,
        'response':
            '[nome: $testerName, peso: 90.0, altura: 1.8, imc: 27.78, classificação: Sobrepeso]'
      },
      {
        'weight': '120',
        'height': 1.80,
        'response':
            '[nome: $testerName, peso: 120.0, altura: 1.8, imc: 37.04, classificação: Obsesidade Grau II (Servera)]'
      },
    };

    for (var values in valuesToTest) {
      Person person = Person(testerName);

      person.setWeight(values['weight'].toString());
      person.setHeight(values['height'].toString());

      ImcCalculator imcCalculator = ImcCalculator(person);

      test('Entrada: $values', () {
        expect(imcCalculator.run(), values['response'].toString());
      });
    }
  });

  group("Should calculate IMC with invalid weight.", () {
    var valuesToTest = {
      {'weight': '0', 'height': 1.50},
      {'weight': '', 'height': 1.80},
      {'weight': 'asdf', 'height': 1.80},
      {'weight': '*.\\', 'height': 1.80},
    };

    for (var values in valuesToTest) {
      Person person = Person('Tester Jr.');

      person.setWeight(values['weight'].toString());
      person.setHeight(values['height'].toString());

      ImcCalculator imcCalculator = ImcCalculator(person);

      test('Entrada: $values', () {
        expect(() => imcCalculator.run(),
            throwsA(TypeMatcher<InvalidWeightException>()));
      });
    }
  });

  group("Should calculate IMC with invalid height.", () {
    var valuesToTest = {
      {'weight': 96, 'height': '0'},
      {'weight': 96, 'height': ''},
      {'weight': 96, 'height': 'asdf'},
      {'weight': 96, 'height': '*.\\'},
    };

    for (var values in valuesToTest) {
      Person person = Person('Tester Jr.');

      person.setWeight(values['weight'].toString());
      person.setHeight(values['height'].toString());

      ImcCalculator imcCalculator = ImcCalculator(person);

      test('Entrada: $values', () {
        expect(() => imcCalculator.run(),
            throwsA(TypeMatcher<InvalidHeightException>()));
      });
    }
  });
}

class FakeStdin extends Mock implements Stdin {}
