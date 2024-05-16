import 'package:flutter/material.dart';

class MyCircleButton extends StatelessWidget {
  final Widget icon;
  MyCircleButton({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,width: 60,
      margin: const EdgeInsets.only(bottom: 25.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.grey])),
      child: icon,
    );
  }
}
