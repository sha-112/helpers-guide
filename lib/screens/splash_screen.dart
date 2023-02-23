import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RotatedBox(quarterTurns: 2, child: Image.asset('assets/background.png'),),
              const Expanded(child: SizedBox.shrink()),
              Image.asset('assets/background.png'),
            ],
          ),
          Column(
            children: [
              const Expanded(child: SizedBox.shrink()),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 80, 60, 60),
                child: Image.asset('assets/helper logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 60, 40, 80),
                child: Image.asset('assets/university logo.png' ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
