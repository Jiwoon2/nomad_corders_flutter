import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false; //타이머가 작동중인지
  int totalPomodoros = 0; //다시 반복된 횟수
  late Timer timer; //버튼 누를때만 타이머 생성하므로 초기화 나중에 함

  //타이머가 바뀔때마다 HomeScreenWidget의 setState실행
  void onTick(Timer timer) {
    //periodic이 실행하는 함수는 인자로 Timer자체를 받음
    if (totalSeconds == 0) {
      //0이 되면 다시 초기화
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      //그렇지 않으면 그냥 -1
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  //타이머 실행
  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1), //주기
      onTick, //함수. 매 초마다 함수 실행
    );
    setState(() {
      isRunning = true;
    });
  }

  //타이머 멈춤
  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  //타이머 리셋
  void onResetPressed() {
    timer.cancel(); //리셋이므로 타이머 멈춤
    setState(() {
      isRunning = false; // false에 해당하는 재생아이콘 변화
      totalSeconds = twentyFiveMinutes; //누르면 숫자가 25로 초기화됨
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    // 0:25:00.0000 -> 25:00
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(color: Colors.brown),
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds), //화면에 보여주는 시간
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              // Row로 두면 flex가 안먹힘 -> 애초에 flex를 colum으로 나눴기 때문에 그런듯
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                  onPressed: //타이머 멈춤, 시작함수
                      isRunning ? onPausePressed : onStartPressed,
                  icon: Icon(isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline),
                ),
                IconButton(
                  //리셋 버튼- code  challenge
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                  onPressed: onResetPressed,
                  icon: Icon(Icons.add_alert),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
