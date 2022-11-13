import 'dart:math';

import 'package:bloc_demo2/number_loop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MyBlocEvent {}

abstract class MyBlocState {}

class InitState extends MyBlocState {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InitState && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class NumberState extends MyBlocState {
  final int number;

  NumberState(this.number);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumberState &&
          runtimeType == other.runtimeType &&
          number == other.number;

  @override
  int get hashCode => number.hashCode;
}

class StartGettingNumberEvent extends MyBlocEvent {}

class StopGettingNumberEvent extends MyBlocEvent {}

class MyBloc extends Bloc<MyBlocEvent, MyBlocState> {
  NumberLoopInterface numberLoop;

  MyBloc({required this.numberLoop}) : super(InitState()) {
    on<StartGettingNumberEvent>((event, emit) async {
      if (numberLoop.isRunning()) {
        return;
      }
      Stream<int> stream = numberLoop.numberLoop();
      await for (var event in stream) {
        emit(NumberState(event));
      }
    });
    on<StopGettingNumberEvent>((event, emit) {
      numberLoop.cancel();
      emit(InitState());
    });
  }
}



// ========== 錯誤寫法 ==========
// stream.listen((event) {
//   emit(NumberState(event));
// });
// =============================