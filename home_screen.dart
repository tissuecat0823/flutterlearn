import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 90;
  //static const fiveMinutes = 300;
  int totalSeconds = twentyFiveMinutes;
  // int restSeconds = fiveMinutes;
  bool isRunning = false;
  int totalPomodoros = 0;

  final _controller = TextEditingController();

  // late int _time;
  late Timer timer; //타이머를 당장 초기화 X,

  void onTick(Timer timer) {
    //periodic이 실행하는 함수는 그 인자로 Timer자체를 받는다.
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = 90;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    //periodic Timer: (duration, (timer) { }) : 주기마다 (timer){}함수를 실행함.
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onClickReset() {
    timer.cancel();
    setState(() {
      totalSeconds = twentyFiveMinutes;
      isRunning = false;
    });
  }

  void clearTotal() {
    setState(() {
      totalPomodoros = 0;
      //totalSeconds = twentyFiveMinutes;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds); //Duration : 시간 간격을 나타내는 클래스
    //위는 문자열을 자르는 방법.
    return duration.toString().split(".").first.substring(2, 7);
  }

  /*String format2(int seconds) {
    var duration = Duration(seconds: seconds); //Duration : 시간 간격을 나타내는 클래스
    //위는 문자열을 자르는 방법.
    return duration.toString().split(".").first.substring(2, 7);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '세트 휴식 타이머',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).cardColor,
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  format(totalSeconds),
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 100,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: isRunning ? onPausePressed : onStartPressed,
                      iconSize: 130,
                      color: Theme.of(context).cardColor,
                      icon: isRunning
                          ? const Icon(Icons.pause_circle_outline)
                          : const Icon(Icons.play_circle_outline),
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: onClickReset,
                          color: Theme.of(context).cardColor,
                          iconSize: 60,
                          icon: const Icon(Icons.replay),
                          style: const ButtonStyle(),
                        ),
                        Text(
                          '타이머\n초기화',
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 170,
                    width: 310,
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.displayLarge!.color,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '세트수',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                        IconButton(
                          onPressed: clearTotal,
                          iconSize: 40,
                          color: Theme.of(context).cardColor,
                          icon: const Icon(Icons.replay),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ), //하드코딩되는 값을 만들게 해줌.
          ],
        ),
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home_outlined),
              iconSize: 30,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
      ),*/
    );
  }
}
