import 'package:bloc_demo2/my_bloc.dart';
import 'package:bloc_demo2/number_loop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Number Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MyBloc _myBloc;

  @override
  void initState() {
    super.initState();
    _myBloc = MyBloc(numberLoop: NumberLoop());
  }

  @override
  void dispose() {
    _myBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<MyBloc, MyBlocState>(
                bloc: _myBloc, builder: (context, state) {
                  if (state is NumberState) {
                    return Text(state.number.toString().padLeft(4, '0'), style: const TextStyle(fontSize: 70));
                  }
                  return const Text('- - - -', style: TextStyle(fontSize: 70));
            }),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _myBloc.add(StartGettingNumberEvent());
            },
            tooltip: 'Start',
            child: const Icon(Icons.play_arrow),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {
              _myBloc.add(StopGettingNumberEvent());
            },
            tooltip: 'Stop',
            child: const Icon(Icons.stop),
          ),
        ],
      ),
    );
  }
}
