import 'package:assignment2/bloc/countdown_bloc.dart';
import 'package:assignment2/components/countdown_input.dart';
import 'package:assignment2/components/countdown_timer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final countdownBloc = CountdownBloc();

  @override
  Widget build(BuildContext context) {
    // print("Home page got rebuild");
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.arrow_back),
            Text("Countdown"),
            Icon(Icons.call),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // shown countdown
            Expanded(
              flex: 1,
              child: CountdownTimer(
                countdownStream: countdownBloc.countdownStream,
              ),
            ),

            // Input section
            Expanded(
              flex: 2,
              child: CountdownInput(
                countdownBloc: countdownBloc,
              ),
            )
          ],
        ),
      ),
    );
  }
}
