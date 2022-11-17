import 'package:flutter/material.dart';
import 'package:assignment2/bloc/input_status_bloc.dart';
import '../bloc/countdown_bloc.dart';

class CountdownInput extends StatelessWidget {
  final CountdownBloc countdownBloc;
  CountdownInput({
    Key? key,
    required this.countdownBloc,
  }) : super(key: key);

  final inputHoursController = TextEditingController();
  final inputMinutesController = TextEditingController();
  final inputSecondsController = TextEditingController();
  final inputStatusBloc = InputStatusBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: inputStatusBloc.inputStatusStream,
      initialData: true,
      builder: (context, AsyncSnapshot snapshot) {
        bool isActive = snapshot.data;
        if (isActive) {
          // reset all inputed value
          inputSecondsController.text = "";
          inputMinutesController.text = "";
          inputHoursController.text = "";
        }
        // print("Input section got rebuild");
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                const Spacer(),
                Expanded(
                  child: TextField(
                    controller: inputHoursController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    enabled: isActive,
                  ),
                ),
                const Text("Hour"),
                const Spacer(),
                Expanded(
                  child: TextField(
                    controller: inputMinutesController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    enabled: isActive,
                  ),
                ),
                const Text("Min"),
                const Spacer(),
                Expanded(
                  child: TextField(
                    controller: inputSecondsController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    enabled: isActive,
                  ),
                ),
                const Text("Sec"),
                const Spacer(),
              ],
            ),
            ElevatedButton(
              onPressed: !isActive
                  ? null
                  : () {
                      // disable all input while countdown still active
                      inputStatusBloc.changeInputStatus();

                      // prevent inserted empty string
                      if (inputHoursController.text == "") {
                        inputHoursController.text = "0";
                      }
                      if (inputMinutesController.text == "") {
                        inputMinutesController.text = "0";
                      }
                      if (inputSecondsController.text == "") {
                        inputSecondsController.text = "0";
                      }

                      countdownBloc.startCountdown(
                        CountdownTime(
                          int.parse(inputHoursController.text),
                          int.parse(inputMinutesController.text),
                          int.parse(inputSecondsController.text),
                        ),
                        inputStatusBloc,
                      );
                    },
              child: const Text("Start"),
            )
          ],
        );
      },
    );
  }
}
