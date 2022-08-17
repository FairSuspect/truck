import 'dart:math';

import 'package:truck/features/main/models/option.dart';

import 'abscract.dart';

const _names = [
  'Insurance',
  'Fuel card',
  'Driver License',
  "Go-Throw permission",
  "Job permission",
  "VIN"
];

class MockOptionService implements OptionService {
  @override
  Future<List<Option>> getAll() async {
    await Future.delayed(const Duration(seconds: 1));
    if (Random().nextBool()) {
      throw Exception();
    }
    final array = List.generate(
      _names.length,
      (index) => Option(
        name: _names[index],
        deadline: DateTime.now().add(Duration(days: (2 - index) * 10)),
        dateCreated: DateTime.now().add(Duration(days: -index * 10)),
      ),
    );

    return array;
  }
}
