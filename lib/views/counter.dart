import 'dart:async';

import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  bool running = false;
  Duration duration = Duration();
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void addTime() {
    final addSeconds = 1;
    // String twoDigits(int n) => n.toString().padLeft(2, '0');
    // final minutes = twoDigits(duration.inMinutes.remainder(60));
    // final seconds = twoDigits(duration.inSeconds.remainder(60));

    setState(() {
      // String twoDigits(int n) => n.toString().padLeft(2, '0');

      final seconds = (duration.inSeconds + addSeconds);
      duration = Duration(seconds: seconds);
      print(duration);
      // final minutes = duration.inMinutes.remainder(60);

      // print(duration);
    });
  }

  void timeGet(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
  }

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 1000), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Center(
        child: running
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //? MINUTES
                  FlipPanel<int>.stream(
                      direction: FlipDirection.up,
                      itemStream: Stream.periodic(
                          Duration(minutes: 1), (count) => count),
                      itemBuilder: (context, value) => Container(
                            color: Colors.black,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Text(
                              // '$value',
                              '${duration.inMinutes.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 150.0,
                                  color: Colors.white),
                            ),
                          ),
                      initValue: 0),

                  //? SECONDS
                  FlipPanel<int>.stream(
                      direction: FlipDirection.up,
                      itemStream: Stream.periodic(
                          Duration(seconds: 1), (count) => count),
                      itemBuilder: (context, value) => Container(
                            color: Colors.black,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Text(
                              // '$value',

                              '${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 150.0,
                                  color: Colors.white),
                            ),
                          ),
                      initValue: 0),
                ],
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    running = true;
                  });
                },
                child: Text('Click TO Start Timer')),
      ),
    );
  }
}
