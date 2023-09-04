import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../shared/globals.dart';

class WaveWidgetTest extends StatefulWidget {
  const WaveWidgetTest({super.key});

  @override
  State<WaveWidgetTest> createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidgetTest> {
  buildCard({
    required Config config,
    Color? backgroundColor = Colors.transparent,
    DecorationImage? backgroundImage,
    double height = 352.0,
  }) {
    return Stack(children: [
      SizedBox(
        height: height,
        width: double.infinity,
        child: WaveWidget(
          config: config,
          backgroundColor: backgroundColor,
          backgroundImage: backgroundImage,
          size: const Size(double.infinity, double.infinity),
          waveAmplitude: 0,
        ),
      ),
      Positioned(
        height: height,
        top: height / 2,
        left: 0,
        right: 0,
        child: LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            width: constraints.maxWidth,
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCard(
          backgroundColor: kPrimaryDarkColor,
          config: CustomConfig(
            gradients: [
              [Colors.red.shade900, const Color(0xEEF44336)],
              [Colors.red[600]!, const Color(0x77E57373)],
              [Colors.orange.shade300, const Color(0x66d27009)],
              [Colors.yellow, const Color(0x55d9c510)]
            ],
            durations: [35000, 19440, 10800, 6000],
            heightPercentages: [0.30, 0.36, 0.45, .58],
            gradientBegin: Alignment.bottomLeft,
            gradientEnd: Alignment.topRight,
          ),
        )
      ],
    );
  }
}
