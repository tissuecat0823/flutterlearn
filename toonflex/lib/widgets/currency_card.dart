import 'package:flutter/material.dart';

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
      offset: isOffSetWant == 0
          ? const Offset(0, 0)
          : Offset(0, isOffSetWant * -21),
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
