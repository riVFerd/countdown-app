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
        backgroundColor: const Color(0xFF189AB4),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Countdown"),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // shown countdown
            Expanded(
              flex: 2,
              child: CountdownTimer(
                countdownStream: countdownBloc.countdownStream,
              ),
            ),

            // Input section
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF05445E),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 50,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      ),
                    ),
                    Expanded(
                      child: CountdownInput(
                        countdownBloc: countdownBloc,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
