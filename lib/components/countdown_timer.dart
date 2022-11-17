import 'package:assignment2/bloc/countdown_bloc.dart';
import 'package:flutter/material.dart';

// Display a HH:MM:SS format timer that recevie data from CountdownBloc
class CountdownTimer extends StatelessWidget {
  final Stream<CountdownTime> countdownStream;
  const CountdownTimer({
    super.key,
    required this.countdownStream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: countdownStream,
      initialData: CountdownTime(0, 0, 0),
      builder: ((context, snapshot) {
        // print("timer got rebuild");
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              snapshot.data!.getHoursText(),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              ":",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              snapshot.data!.getMinutesText(),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              ":",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              snapshot.data!.getSecondsText(),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      }),
    );
  }
}
