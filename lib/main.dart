import 'dart:developer';

import 'package:flutter/material.dart';
import 'state/cart_state.dart';
import 'state/products_state.dart';
import 'package:provider/provider.dart';

import 'screens/products_screen.dart';
import 'state/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterState()),
        ChangeNotifierProvider(create: (_) => ProductsState()),
        ChangeNotifierProvider(create: (_) => CartState()),
      ],
      child: MaterialApp(
        title: 'Lecture 6',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const ProductsScreen(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    log('MyHomePage.build');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have pushed the button this many times:'),
            CounterText(),
          ],
        ),
      ),
      floatingActionButton: const AddButton(),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.watch<CounterState>().counter;
    log('CounterText.build');

    return Text(
      '$count',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    log('AddButton.build');

    return FloatingActionButton(
      onPressed: context.read<CounterState>().increment,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
