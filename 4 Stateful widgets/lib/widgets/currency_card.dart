import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  final bool isInverted; //색반전

  final double offX, offY;

  final _blackColor = Color(0xFF1F2123); //_는 private

  CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.isInverted,
    required this.offX,
    required this.offY,
  });

  @override
  Widget build(BuildContext context) {
    return  Transform.translate(
      offset: Offset(offX, offY),
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: isInverted ? Colors.white : _blackColor,
            borderRadius: BorderRadius.circular(25),
          ),

            child: Padding(
              padding: const EdgeInsets.all(30),

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
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween, //not work. 이유?-공간문제?
                        children: [
                          Text(
                            amount,
                            style: TextStyle(
                              color: isInverted ? _blackColor : Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
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
                    scale: 2.2, //5배
                    child: Transform.translate(
                      offset: Offset(0, 12),
                      child: Icon(
                        icon,
                        color: isInverted ? _blackColor : Colors.white,
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
