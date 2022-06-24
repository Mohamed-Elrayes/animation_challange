import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Flutter Demo',
    home: MainClass(),
  ));
}

class MainClass extends StatefulWidget {
  const MainClass({super.key});

  @override
  State<MainClass> createState() => _MainClassState();
}

class _MainClassState extends State<MainClass> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          tween: Tween<double>(begin: 0.0, end: 1.0),
          child: const FlutterLogo(size: 200),
          builder: (context, value, child) =>
              Opacity(opacity: value, child: child),
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}

class AnimatedW extends AnimatedWidget {
  const AnimatedW({super.key, required super.listenable});
  static final _tween = Tween<double>(begin: 0.0, end: 5.0);
  static final _tween2 = Tween<double>(begin: 0.0, end: 1.0);
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    print(_tween.evaluate(animation));
    return Opacity(
      opacity: _tween2.evaluate(animation),
      child: const FlutterLogo(),
    );
  }
}
