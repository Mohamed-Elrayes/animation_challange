import 'package:animation_challange/logger.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const Scaffold(body: BottomSheetWidget()),
  ));
}

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation heightAnimation;
  late Animation opacityAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    heightAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut)));

    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.6, 1.0, curve: Curves.slowMiddle)));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.isAnimating.logE('isAnimating');
    return GestureDetector(
        onTap: () {
          if (!controller.isAnimating) {
            if (controller.isDismissed) {
              controller.forward();
            } else {
              controller.reverse();
            }
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) => AnimatedBuilder(
            animation: controller,
            builder: (context, child) => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  color: const Color(0xFFAACCEE),
                ),
                AnimatedContainer(
                  duration: controller.duration!,
                  curve: Curves.easeInOut,
                  alignment: Alignment.center,
                  height: constraints.maxHeight / 2 * heightAnimation.value,
                  color: const Color(0xFFEECCAA),
                  child: AnimatedOpacity(
                      duration: controller.duration!,
                      opacity: opacityAnimation.value,
                      child: const Text("Geeks animations!")),
                ),
              ],
            ),
          ),
        ));
  }
}
