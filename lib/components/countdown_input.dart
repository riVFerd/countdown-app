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
    const inputFieldStyle = InputDecoration(
      hintText: "0",
      hintStyle: TextStyle(color: Colors.white),
    );

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
            Container(
              decoration: const BoxDecoration(),
              child: Row(
                children: [
                  const Spacer(),
                  Expanded(
                    child: TextField(
                      controller: inputHoursController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      enabled: isActive,
                      style: const TextStyle(color: Colors.white),
                      decoration: inputFieldStyle,
                    ),
                  ),
                  const Text(
                    "Hour",
                    style: TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  Expanded(
                    child: TextField(
                      controller: inputMinutesController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      enabled: isActive,
                      style: const TextStyle(color: Colors.white),
                      decoration: inputFieldStyle,
                    ),
                  ),
                  const Text(
                    "Min",
                    style: TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  Expanded(
                    child: TextField(
                      controller: inputSecondsController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      enabled: isActive,
                      style: const TextStyle(color: Colors.white),
                      decoration: inputFieldStyle,
                    ),
                  ),
                  const Text(
                    "Sec",
                    style: TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white.withOpacity(0.5);
                    } else if (states.contains(MaterialState.disabled)) {
                      return Colors.grey;
                    }
                    return Colors.white;
                  },
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
              onPressed: !isActive
                  ? null
                  : () {
                      // Todo: prevent all event to start when all input are empty

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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Start",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF05445E),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
