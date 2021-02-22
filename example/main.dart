import 'package:flutter_test/flutter_test.dart';

import 'package:testify/testify.dart';

void main() {
  List<TestCase<Counter>> testCaseList = [
    TestCase<Counter>(
      description: 'properly increments the counter',
      assembler: () => Counter(),
      actors: [
        (counter) {
          counter.increment();
          return counter;
        },
      ],
      matchers: [
        (counter) {
          expect(counter.count, equals(1));
        }
      ],
    ),
  ];

  TestCaseExecutor<Counter> testCaseExecutor = TestCaseExecutor(testCaseList);
  testCaseExecutor.run();
}

class Counter {
  int count = 0;

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }
}
