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
  const TestCaseExecutor(this.testCaseList);

  final List<TestCase<T>> testCaseList;

  void run() {
    for (var _testCase in testCaseList) {
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
  const TestCase({this.description, this.assembler, this.actors, this.matchers})
      : assert(description != null),
        assert(assembler != null),
        assert(actors != null),
        assert(matchers != null);
  final String description;
  final T Function() assembler;
  final List<T Function(T)> actors;
  final List<dynamic Function(T)> matchers;
}
