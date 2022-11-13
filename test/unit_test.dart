import 'package:bloc_demo2/my_bloc.dart';
import 'package:bloc_demo2/number_loop.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'unit_test.mocks.dart';

class StubNumberLoop implements NumberLoopInterface {
  List<int> numbers;

  StubNumberLoop({required this.numbers});

  @override
  Stream<int> numberLoop() {
    return Stream.fromIterable(numbers);
  }

  @override
  void cancel() {}

  @override
  bool isRunning() {
    return false;
  }
}

// @GenerateMocks([Random, NumberLoop])
void main() {
  // test('test random', () {
  //   MockRandom mockRandom = MockRandom();
  //   when(mockRandom.nextInt(any)).thenReturn(7);
  //   expect(mockRandom.nextInt(100), 7);
  // });

  // test('test NumberLoop', () {
  //   var loop = MockNumberLoop();
  //   when(loop.numberLoop()).thenAnswer((_) => Stream.fromIterable([1, 2, 3]));
  //   expect(loop.numberLoop(), emitsInOrder([1, 2, 3]));
  // });

  test('test NumberLoop', () {
    var loop = StubNumberLoop(numbers: [1, 2, 3]);
    expect(loop.numberLoop(), emitsInOrder([1, 2, 3]));
  });

  test('test mybloc', () {
    var bloc = MyBloc(numberLoop: StubNumberLoop(numbers: [1, 2, 3]));
    bloc.add(StartGettingNumberEvent());
    expectLater(bloc.stream,
        emitsInOrder([NumberState(1), NumberState(2), NumberState(3)]));
  });

  blocTest('test MyBloc',
      build: () {
        return MyBloc(numberLoop: StubNumberLoop(numbers: [1, 2, 3]));
      },
      act: (bloc) => bloc.add(StartGettingNumberEvent()),
      expect: () => [NumberState(1), NumberState(2), NumberState(3)]);
}
