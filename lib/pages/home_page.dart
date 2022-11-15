import 'package:assignment2/bloc/countdown_bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final inputHoursController = TextEditingController();
  final inputMinutesController = TextEditingController();
  final inputSecondsController = TextEditingController();

  bool isCountdownStart = false;

  final countdownBloc = CountdownBloc();

  @override
  Widget build(BuildContext context) {
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
            // countdown section
            StreamBuilder(
              stream: countdownBloc.countdownStream,
              builder: ((context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data!.hours.toString()),
                    const Text(":"),
                    Text(snapshot.data!.minutes.toString()),
                    const Text(":"),
                    Text(snapshot.data!.seconds.toString()),
                  ],
                );
              }),
            ),

            // Input section
            Row(
              children: [
                const Spacer(),
                Expanded(
                  child: TextField(
                    controller: inputHoursController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const Text("HH"),
                Expanded(
                  child: TextField(
                    controller: inputMinutesController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const Text("MM"),
                Expanded(
                  child: TextField(
                    controller: inputSecondsController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const Text("SS"),
                const Spacer(),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  isCountdownStart = !isCountdownStart;
                  countdownBloc.startCountdown(
                    CountdownTime(
                      int.parse(inputHoursController.text),
                      int.parse(inputMinutesController.text),
                      int.parse(inputSecondsController.text),
                    ),
                  );
                });
              },
              child: const Text("Start"),
            )
          ],
        ),
      ),
    );
  }
}
