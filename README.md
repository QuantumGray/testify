# testify
### scalable Flutter testing framework

## declaratively create test cases and easily run them

specify virtually any test case for a testable unit by ...
- specifying unit type parameter T inside TestCase<T>
- add a test description
- provide an assembler "builder" function and return the unit
- act on the unit and return it
- assert unit with usual test utility
---
 ````dart
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
    TestCase<Counter>(
      description: 'properly decrements the counter',
      assembler: () => Counter(),
      actors: [
        (counter) {
          counter.decrement();
          return counter;
        },
      ],
      matchers: [
        (counter) {
          expect(counter.count, equals(-1));
        }
      ],
    ),
  ];
````
---
### run test cases with a TestCaseExecutor
---
````dart
var testCaseExecutor = TestCaseExecutor(testCaseList);
testCaseExecutor.run();
````
