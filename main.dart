import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override //build 메소드는 Widget을 return해줘야함.
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 배경색을 투명으로 설정
      statusBarIconBrightness: Brightness.light, // 아이콘 색상을 밝은 색상으로 설정
    ));
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Wallet',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1F2123),
                ),
              ),
              Icon(
                Icons.settings,
                size: 30,
                color: Color(0xFF1F2123),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFF1B33B),
        ),
        backgroundColor: const Color(0xFF181818), //Colos.optionsColor(색상).
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Hey, KimYewon',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Welcom back',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Total balance',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '₩ 11, 250, 340',
                  style: TextStyle(
                    color: Colors.white.withOpacity(1),
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Button(
                        //Reusable Widgets. ./button.dart import
                        text: 'Transfer',
                        backgroundColor: Color(0xFFF1B33B),
                        textColor: Colors.black),
                    Button(
                        text: 'Request',
                        backgroundColor: Color(0xFF1F2123),
                        textColor: Colors.white),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Wallet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CurrencyCard(
                        name: 'Euro',
                        code: 'EUR',
                        amount: '6 428',
                        icon: Icons.euro_symbol_rounded,
                        isInverted: false,
                        isOffSetWant: 0), //isOffSetWant=1 : don't use offset
                    CurrencyCard(
                        name: 'Bitcoin',
                        code: 'BTC',
                        amount: '0 127',
                        icon: Icons.currency_bitcoin_sharp,
                        isInverted: true,
                        isOffSetWant: 1),
                    CurrencyCard(
                        name: 'Dollar',
                        code: 'USD',
                        amount: '4 721',
                        icon: Icons.attach_money_rounded,
                        isInverted: false,
                        isOffSetWant: 2),
                    CurrencyCard(
                        name: 'Yen',
                        code: 'JPY',
                        amount: '300 000',
                        icon: Icons.currency_yen_rounded,
                        isInverted: true,
                        isOffSetWant: 3),
                    CurrencyCard(
                        name: 'Pound',
                        code: 'GBP',
                        amount: '4 312',
                        icon: Icons.currency_pound_rounded,
                        isInverted: false,
                        isOffSetWant: 4),
                    CurrencyCard(
                        name: 'Yuan',
                        code: 'CNY',
                        amount: '0 314',
                        icon: Icons.currency_yen_rounded,
                        isInverted: true,
                        isOffSetWant: 5),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: const Color(0xFF181818).withOpacity(1),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              bottomNavParts(navIcon: Icons.home, navTitle: 'Home'),
              bottomNavParts(navIcon: Icons.place, navTitle: 'Place'),
              bottomNavParts(navIcon: Icons.search, navTitle: 'Search'),
              bottomNavParts(navIcon: Icons.chat, navTitle: 'Chatting'),
              bottomNavParts(navIcon: Icons.person, navTitle: 'Mypage'),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  //final Color boxColor, nameColor, codeColor, amountColor, iconColor;
  final bool isInverted;
  final _blackColor =
      const Color(0xFF1F2123); //_private var: class 내에서만 접근 가능하다.
  //final Color bgColor;
  //변수를 선언할 땐, 카드 내에 있는 것들 중 어떤것을 커스터마이징 할건지 파악
  final double isOffSetWant;
  const CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    /*required this.nameColor,
    required this.codeColor,
    required this.amountColor,
    required this.iconColor,
    required this.boxColor,*/
    required this.isInverted,
    required this.isOffSetWant,
  });
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset:
          isOffSetWant == 0 ? const Offset(0, 0) : Offset(0, isOffSetWant * -8),
      child: Container(
        clipBehavior: Clip.hardEdge, //Container에서 overflow되는 부분을 처리
        //Card start;
        decoration: BoxDecoration(
          color: isInverted
              ? Colors.white
              : const Color(0xFF1F2123), //const Color(0xFF1F2123),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: isInverted ? _blackColor : Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        amount,
                        style: TextStyle(
                          color: isInverted ? _blackColor : Colors.white,
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        code,
                        style: TextStyle(
                          color: isInverted
                              ? _blackColor
                              : Colors.white.withOpacity(0.8),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.scale(
                scale: 2.3,
                child: Transform.translate(
                  offset: const Offset(-5, 9),
                  child: Icon(
                    icon,
                    color: isInverted ? _blackColor : Colors.white, //
                    size: 88,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class bottomNavParts extends StatelessWidget {
  const bottomNavParts({
    super.key,
    required this.navIcon,
    required this.navTitle,
  });

  final IconData navIcon;
  final String navTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          color: const Color(0xFFF1B33B),
          navIcon,
          size: 35,
        ),
        Text(
          navTitle,
          style: const TextStyle(
            color: Color(0xFFF1B33B),
          ),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const Button(
      {super.key,
      required this.text,
      required this.backgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 40,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
      ),
    );
  }
}



/*
 const CurrencyCard(
                      name: 'Euro',
                      code: 'EUR',
                      amount: '6 742',
                      icon: Icons.euro_symbol_rounded,
                      isInverted: false,
                    ),
                    Transform.translate(
                      offset: const Offset(0, -23),
                      child: const CurrencyCard(
                        name: 'Bitcoin',
                        code: 'BTC',
                        amount: '0 142',
                        icon: Icons.currency_bitcoin_sharp,
                        isInverted: true,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -46),
                      child: const CurrencyCard(
                        name: 'Dollar',
                        code: 'USD',
                        amount: '4 831',
                        icon: Icons.attach_money_rounded,
                        isInverted: false,
                      ),
                      
                    ),
 */

//App의 root, Material: 구글, Cupertino: 애플 스타일
//어떤 family style을 사용할지 선택하는것.
// class 작성시마다 , 끝에 붙이기
