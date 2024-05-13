import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_counter_bloc/blocs/counter/counter_bloc.dart';
import 'package:my_counter_bloc/other_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        title: 'MyCounter Bloc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CounterBloc, CounterState>(
      listener: (context, state) {
        if (state.counter == 3) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    content: Text('Counter is ${state.counter}'));
              });
        }

        if (state.counter < 0) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return OtherPage();
          }));
        }
      },
      child: Scaffold(
        body: Center(
          child: Text(
            '${context.watch<CounterBloc>().state.counter}',
            style: TextStyle(fontSize: 52.0),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<CounterBloc>().add(IncrementCounterEvent());
              },
              heroTag: 'increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 10.0),
            FloatingActionButton(
              onPressed: () {
                context.read<CounterBloc>().add(DecrementCounterEvent());
              },
              heroTag: 'decrement',
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
