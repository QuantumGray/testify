import 'package:flutter_test/flutter_test.dart';

/// interface for a [TestCaseExecutor] on the unit of type [T extends Object]
///
/// provide a list of [TestCase<T extends Object>] and invoke .run() method
/// for running them
/// ---
/// ````dart
/// var testCaseExecutor = TestCaseExecutor(testCaseList);
/// testCaseExecutor.run();
///
/// ````
/// Assemblies of testCases do not have an effect on each other because they are
/// naturally disposed
/// except if they are Singeltons
/// write your own [TestCaseExecutor] by implementing it

class TestCaseExecutor<T> {
  const TestCaseExecutor(this._testCaseList);

  /// list of test cases of type T that the executor runs
  final List<TestCase<T>> _testCaseList;

  /// runs the list of test cases sequentially by first assembling, acting and then asserting for the specfic test case
  void run() {
    for (var _testCase in _testCaseList) {
      T _a;
      _a = _testCase.assembler();
      _testCase.actors.forEach((actorFunc) {
        _a = actorFunc(_a);
      });
      _testCase.matchers.forEach((matcherFunc) {
        test(_testCase.description, () {
          matcherFunc(_a);
        });
      });
    }
  }
}

/// Most fundamental testing unit
///
/// create a [TestCase] by:
/// - describing the test inside [description]
/// - assembling ("building") the unit inside [assemblers] functions
/// - acting on the assembled unit through [actors] functions
/// - match ("assert") testable properties inside [matchers] functions
/// ---
/// ````dart
/// var testCases = [
///   TestCase<CounterUnit>(
///     "should increment value",
///     [],
///     [],
///     [],
///   )
///
/// ]
/// ````
class TestCase<T> {
  const TestCase({
    required this.description,
    required this.assembler,
    required this.actors,
    required this.matchers,
  });

  /// description for the testcase to be shown inside test outputs
  final String description;

  /// should be a function that builds the unit to be tested and returns it
  final T Function() assembler;

  /// list of functions that act upon the unit and return the unit afterwards
  final List<T Function(T)> actors;

  /// assertions the acted upon unit has to tested against
  final List<dynamic Function(T)> matchers;
}
